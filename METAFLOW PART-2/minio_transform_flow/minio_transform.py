from metaflow import FlowSpec, step
import pandas as pd
from minio import Minio
from minio.error import S3Error


class MiniIOFlow(FlowSpec):
    @step
    def start(self):
        data = {'Name': ['Alice', 'Bob', 'Charlie'],
                'Age': [24, 30, 22]}
        self.df = pd.DataFrame(data)
        self.data_path = 'data/original_data.csv'
        self.df.to_csv(self.data_path, index=False)
        print("Original Data Saved Successfully")
        self.next(self.transform_minio)

    @step
    def transform_minio(self):
        print("Transforming Data")
        self.df= pd.read_csv(self.data_path)
        self.df['Age'] = self.df['Age'] + 5
        self.transform_data_path = 'output/transformed_data.csv'
        self.df.to_csv(self.transform_data_path)

        self.next(self.upload_to_minio)
    @step
    def upload_to_minio(self):
        minio_client = Minio(
            "localhost:9000",
            access_key="minioadmin",
            secret_key="minioadmin",
            secure=False
        )
        try:
            if not minio_client.bucket_exists('mybucket'):
                minio_client.make_bucket('mybucket')
        except S3Error as e:
            print("Error Occurred:", e)
        try:
            minio_client.fput_object('mybucket', 'transformed_data.csv', self.transform_data_path)
            print("File Uploaded Successfully")
        except S3Error as e:
            print("Error Occurred:", e)

        self.next(self.end)
    @step
    def end(self):
        print("CSV transform and Print task completed successfully")

if __name__ == '__main__':
    MiniIOFlow()
