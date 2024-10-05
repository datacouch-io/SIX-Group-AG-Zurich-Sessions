# Lab 8: Versioning in MinIO using Python SDK

**Time:** 20 Minutes

## Lab Overview

The SIX Groups company requires a robust versioning strategy for managing its financial data files stored in MinIO. This lab will guide you through enabling versioning on a bucket, uploading files with versioning enabled, checking versioning information, downloading specific versions, deleting specific versions, and restoring files to a previous version using the MinIO Python SDK.

---

## Part 1: Enabling Versioning on a Bucket

**Objective:**
Enable versioning on the `sixgroups-finance` bucket, which will store critical financial records requiring version control.

---

## Steps

### Step 1: Initialize the MinIO Client

1. **Connect to the MinIO Server:**
   - Use the Python SDK to connect to the MinIO server.

### Step 2: Create the Bucket (if necessary)

1. **Check if the `sixgroups-finance` Bucket Exists:**
   - If the bucket does not already exist, create it. You can reuse the previous code used to create a bucket.

### Step 3: Enable Versioning

1. **Enable Versioning on the Bucket:**
   - Enable versioning on the `sixgroups-finance` bucket to ensure that every change to an object is stored as a new version.

---

## Python Code Example

```python
from minio import Minio
from minio.error import S3Error
from minio.commonconfig import ENABLED
from minio.versioningconfig import VersioningConfig

def enable_versioning(client, bucket_name):
    try:
        # TODO: Use client.set_bucket_versioning(bucket_name, VersioningConfig(ENABLED)) to enable versioning
        client.set_bucket_versioning(bucket_name, VersioningConfig(ENABLED))
        print(f"Versioning enabled for bucket '{bucket_name}'.")
    except S3Error as e:
        print(f"Failed to enable versioning for bucket '{bucket_name}': {e}")

def main():
    # TODO: Provide your access key & secret access key
    client = Minio(
        "127.0.0.1:9000",
        access_key="your access key",
        secret_key="your secret key",
        secure=False,
    )

    # TODO: Provide name of the bucket where you want to set versioning
    bucket_name = "sixgroups-finance"
    enable_versioning(client, bucket_name)

if __name__ == "__main__":
    main()
```

## Part 2: Uploading Files Multiple Times to the Versioned Bucket

**Objective:**
Upload multiple versions of the `transaction_log_2023.csv` file to the `sixgroups-finance` bucket.

---

## Steps

### Step 1: Prepare the File

1. **Make Minor Changes to the File:**
   - Make minor changes to the `transaction_log_2023.csv` file each time before uploading it to simulate different versions.

### Step 2: Upload Files

1. **Upload the File Multiple Times:**
   - Upload the file multiple times to the `sixgroups-finance` bucket to create different versions of the file.

   - The file is provided under `labs/Lab8_Versioning/data/transaction_log_2023.csv`.

---

## Python Code Example

```python
from minio import Minio
from minio.error import S3Error  # Correct import for error handling

def upload_file(client, bucket_name, file_path, object_name):
    # Upload a file
    try:
        result = client.fput_object(bucket_name, object_name, file_path)
        print(f"Created {result.object_name} object; etag: {result.etag}, version-id: {result.version_id}")
    except S3Error as e:
        print(f"Failed to upload '{file_path}': {e}")

def main():
    # Create a MinIO Client
    client = Minio(
        "127.0.0.1:9000",
        access_key="your access key",
        secret_key="your secret key",
        secure=False,  # Set to True if using HTTPS
    )

    bucket_name = "sixgroups-finance"
    file_path = "labs/Lab8_Versioning/data/transaction_log_2023.csv"
    object_name = "transaction_log_2023.csv"

    upload_file(client=client, bucket_name=bucket_name, file_path=file_path, object_name=object_name)

if __name__ == "__main__":
    main()
```

## Part 3: Download Specific Version of File

**Objective:**
Download a specific version of the `transaction_log_2023.csv` file to your local machine for analysis.

---

## Steps

### Step 1: Check for the Version

1. **Access the Version Information:**
   - Go to the Object Browser in the MinIO Console and select the `sixgroups-finance` bucket.
   - Select the `transaction_log_2023.csv` file and click on "Display Versions."
   - Copy the version ID of the specific version you want to download.

### Step 2: Download the Specific Version

1. **Use the MinIO Python SDK to Download the Specific Version:**
   - Modify the code provided below to download the file using the version ID you copied.

   - The code is provided at the following location: `labs/Lab8_Versioning/challenge/download_object_version.py`.

---

## Python Code Example

```python
from minio import Minio

# Initialize the MinIO Client
client = Minio(
        "127.0.0.1:9000",
        access_key="your access key here",
        secret_key="your secret key here",
        secure=False,
)

# Download a specific version of the object
client.fget_object(
    "sixgroups-finance",          # Bucket name
    "transaction_log_2023.csv",   # Object name
    "transaction_versioned.csv",  # Local file name to save the downloaded version
    version_id="version id to download",  # Version ID to download
)
```

## End of Lab

You have successfully completed the lab, where you downloaded a specific version of the  `transaction_log_2023.csv`file from the  `sixgroups-finance`  bucket using the MinIO Python SDK.
