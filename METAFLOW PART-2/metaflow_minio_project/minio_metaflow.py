from metaflow import FlowSpec,step
from minio import Minio
from minio.error import S3Error
import pandas as pd


class  MinIOFLow(FlowSpec):
    @step
    def start(self):
        data = {'Name':['Alice','Bob','Charlie'],
                'Age':[24,30,22]}
        self.df = pd.DataFrame(data)
        self.data_path = 'data/sample_data.csv'
        self.df.to_csv(self.data_path,index=False)
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
            minio_client.fput_object('mybucket','sample_data.csv',self.data_path)
            print("File Uploaded Successfully")
        except S3Error as e:
            print("Error Occurred:", e)

        self.next(self.retrieve_from_minio)

    @step
    def retrieve_from_minio(self):
        minio_client = Minio(
            "localhost:9000",
            access_key="minioadmin",
            secret_key="minioadmin",
            secure=False
        )
        self.output_path = 'output/downloaded_data.csv'
        try:
            minio_client.fget_object('mybucket','sample_data.csv',self.output_path)
            print("File Downloaded Successfully")
        except S3Error as e:
            print("Error Occurred:", e)
        self.downloaded_df = pd.read_csv(self.output_path)
        print("Printing  Downloaded Dataframe")
        print(self.downloaded_df)
        self.next(self.end)

    @step
    def end(self):
        print("CSV Upload Download and Print task completed successfully")

if __name__ == '__main__':
    MinIOFLow()
