from minio import Minio
from urllib3 import PoolManager
import certifi

# Create HTTP client with a self-signed certificate
http_client = PoolManager(
    cert_reqs='CERT_REQUIRED',  # Ensure certificate is required
    ca_certs='/path/to/your/ca.crt'  # Path to your self-signed certificate
)

# Initialize the MinIO client with custom HTTP client
client = Minio(
    "minio.example.com:9000",  # MinIO server endpoint with HTTPS
    access_key="YOUR-ACCESS-KEY",
    secret_key="YOUR-SECRET-KEY",
    secure=True,
    http_client=http_client
)

# Example: Listing buckets
buckets = client.list_buckets()
for bucket in buckets:
    print(bucket.name, bucket.creation_date)
