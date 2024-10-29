from metaflow import FlowSpec, step
from minio import Minio
from minio.error import S3Error

class CreateBucketFlow(FlowSpec):
    bucket_name = "mybucket"

    @step
    def start(self):
        print("Starting task 1")
        self.next(self.create_bucket)

    @step
    def create_bucket(self):
        minio_client =Minio(
            "localhost:9000",
            access_key="minioadmin",
            secret_key="minioadmin",
            secure=False
        )
        try:
            minio_client.make_bucket(self.bucket_name)
            print(f"Bucket '{self.bucket_name}' created successfully")
        except S3Error as e:
            if e.code == 'BucketAlreadyOwnedByYou':
                print("Bucket already exist")
            else:
                print("Error in creating bucket")
                raise
        self.next(self.end)

    @step
    def end(self):
        print("Bucket Creation task completed successfully")

if __name__=='__main__':
    CreateBucketFlow()


