from minio import Minio
from minio.sseconfig import Rule, SSEConfig

# Initialize the MinIO client
client = Minio(
        "127.0.0.1:9000",
        access_key="hgWVh2MUy0v7i2Hzq2NR",
        secret_key="hfmaMc57uRhEGy0d70XlPbqzeMdRnFyxmVSYMMdZ",
        secure=True
)

client.set_bucket_encryption(
    "my-bucket-2", SSEConfig(Rule.new_sse_s3_rule()),
)