from minio import Minio
from minio.sse import SseCustomerKey
import os

# Initialize the MinIO client
client = Minio(
        "127.0.0.1:9000",
        access_key="hgWVh2MUy0v7i2Hzq2NR",
        secret_key="hfmaMc57uRhEGy0d70XlPbqzeMdRnFyxmVSYMMdZ",
        secure=True
)

# Generate a 256-bit (32-byte) encryption key
encryption_key = os.urandom(32)

# Create an SSE-C encryption key using the generated encryption key
ssec = SseCustomerKey(encryption_key)

# Specify the bucket name
bucket_name = "my-bucket-2"

# Create the bucket if it doesn't exist
found = client.bucket_exists(bucket_name)
if not found:
    client.make_bucket(bucket_name)
    print(f"Bucket '{bucket_name}' created.")
else:
    print(f"Bucket '{bucket_name}' already exists.")

# Path to the file to be uploaded
file_path = "/home/training/sixgroups/minio_developer/instructor/data/movies.csv"

# Upload the object with client-side encryption
with open(file_path, 'rb') as file_data:
    file_stat = os.stat(file_path)
    client.put_object(
        bucket_name,  # Name of your bucket
        "encrypted-movies.csv",  # Object name in the bucket
        file_data,
        file_stat.st_size,
        part_size=10 * 1024 * 1024,  # Set part size to 10MB for multipart uploads
        sse=ssec  # Use SSE-C for client-side encryption
    )

print("File uploaded successfully with client-side encryption (SSE-C).")

# Now, let's download and decrypt the object
response = client.get_object(
    bucket_name,
    "encrypted-moviescsv",
    sse=ssec  # Use the same SSE-C key for decryption
)

# Save the downloaded file
with open("downloaded-file.csv", 'wb') as file:
    for data in response.stream(1024):
        file.write(data)

response.close()
response.release_conn()

print("File downloaded and decrypted successfully.")
