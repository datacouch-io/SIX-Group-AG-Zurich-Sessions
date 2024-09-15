# Lab 7: Object Operations for Financial Data Using MinIO Python SDK

**Time:** 25 Minutes

## Scenario: Document Management for SIX Groups

**Background:**
SIX handles a large volume of financial documents, reports, and transaction data that must be securely stored, accessed, and managed. As part of their digital infrastructure, SIX has chosen MinIO to store and manage these documents. Your task is to implement a Python application that performs various object operations, including upload, listing, download, and more, on these financial documents.

---

## Part 1: Uploading Financial Documents

**Problem Statement:**
SIX has received several financial reports and transaction records that need to be uploaded to MinIO for long-term storage and secure access. Each document must be uploaded with metadata to identify the document type and the department responsible for it.

---

## Steps

### Step 1: Initialize MinIO Client

1. **Start by Connecting to the MinIO Server:**
   - Reuse the initialization code from previous labs to connect to the MinIO server using the Python SDK with the provided access key and secret key.

### Step 2: Upload Objects

1. **Upload Financial Documents:**
   - Upload the transaction and account summary files (`transaction_log_2023.csv` & `account_summary_2023.csv`) with metadata indicating that they belong to the "finance" department.
   - These files are located in your `minio_developer/labs/Lab7_Object_Operations/data` folder.
   - Upload the files to the `sixgroups-finance` bucket created in the previous labs.

---

## Python Code Example

```python
import os
from minio import Minio
from minio.error import S3Error

def upload_file_with_metadata(client, bucket_name, file_path, object_name):
    try:
        # TODO: Create metadata for the file
        metadata = {"department": "finance", "document_type": "report"}

        # TODO: Use client.fput_object(bucket_name, object_name, file_path, metadata) API to upload
        result = client.fput_object(bucket_name, object_name, file_path, metadata=metadata)
        print(f"Created {result.object_name} object; etag: {result.etag}, version-id: {result.version_id}")
    except S3Error as e:
        print(f"Failed to upload '{file_path}': {e}")

def upload_multiple_files(client, bucket_name, directory_path):
    for filename in os.listdir(directory_path):
        file_path = os.path.join(directory_path, filename)
        if os.path.isfile(file_path):
            # TODO: Call upload_file_with_metadata method
            upload_file_with_metadata(client, bucket_name, file_path, filename)

def main():
    # TODO: Provide your access key & secret key here
    client = Minio(
        "127.0.0.1:9000",
        access_key="your access key",
        secret_key="your secret key",
        secure=False,
    )

    # TODO: Provide the name of the bucket where to upload
    bucket_name = "sixgroups-finance"
    directory_path = "minio_developer/labs/Lab7_Object_Operations/data"  # Directory containing files to upload

    upload_multiple_files(client=client, bucket_name=bucket_name, directory_path=directory_path)

if __name__ == "__main__":
    main()
```

## Part 2: Listing Financial Documents

**Problem Statement:**
The Finance and Operations departments need to verify that all documents have been successfully uploaded to MinIO. They also need to list all documents stored in the bucket to ensure everything is in place.

---

## Steps

### Step 1: List Objects in the Bucket

1. **List All Documents:**
   - List all the documents stored in the `sixgroups-finance` bucket that were uploaded in the last step.

---

## Python Code Example

```python
from minio import Minio
from minio.error import S3Error  # Correct import for error handling

def list_objects(client, bucket_name):
    # List all objects in the bucket
    try:
        # TODO: Use client.list_objects(bucket_name) API to list objects
        objects = client.list_objects(bucket_name)  # Get the list of objects
        print("Objects in the bucket:")
        for obj in objects:
            print(obj.object_name)
    except S3Error as e:
        print(f"Failed to list objects in '{bucket_name}': {e}")

def main():
    # TODO: Provide your access key and secret key
    client = Minio(
        "127.0.0.1:9000",
        access_key="your access key",
        secret_key="your secret key",
        secure=False,  # Set to True if using HTTPS
    )
    # TODO: Provide appropriate bucket name
    bucket_name = "sixgroups-finance"

    list_objects(client=client, bucket_name=bucket_name)

if __name__ == "__main__":
    main()
```

## Part 3: Downloading Financial Documents

**Problem Statement:**
The Finance department needs to download transaction logs and account summaries for processing.

---

## Steps

### Step 1: Download Objects

1. **Download Financial Documents:**
   - Download the `transaction_log_2023.csv` and `account_summary_2023.csv` files from the `sixgroups-finance` bucket.

---

## Python Code Example

```python
from minio import Minio
from minio.error import S3Error

def download_object(client, bucket_name, object_name, download_path):
    try:
        # TODO: Use client.fget_object(bucket_name, object_name, download_path) API to download
        client.fget_object(bucket_name, object_name, download_path)
        print(f"File '{object_name}' downloaded successfully to '{download_path}'.")
    except S3Error as e:
        print(f"Failed to download '{object_name}': {e}")

def main():
    # TODO: Use your access key and secret access key
    client = Minio(
        "127.0.0.1:9000",
        access_key="your access key",
        secret_key="your secret key",
        secure=False,  # Set to True if using HTTPS
    )

    bucket_name = "sixgroups-finance"

    # TODO: Define the files to download and their local paths
    files_to_download = {
        "transaction_log_2023.csv": "downloaded_transactions_logs.csv",
        "account_summary_2023.csv": "downloaded_accounts_summary.csv"
    }

    for object_name, download_path in files_to_download.items():
        download_object(client, bucket_name, object_name, download_path)

if __name__ == "__main__":
    main()
```

## Part 4: Copying Data Between Buckets

**Objective:**
Copy critical financial transaction data files from the `sixgroups-finance` bucket to the `sixgroups-finance-archive` bucket. This operation is part of the data migration process to ensure that the transaction logs are archived.

**Files to Copy:**
- `transaction_log_2023.csv`

---

## Steps

### Step 1: Create the Archive Bucket

1. **Create the `sixgroups-finance-archive` Bucket:**
   - Ensure the `sixgroups-finance-archive` bucket exists. If it does not exist, create it using the MinIO Python SDK.

### Step 2: Copy Files Between Buckets

1. **Copy Files from `sixgroups-finance` to `sixgroups-finance-archive`:**
   - Copy the `transaction_log_2023.csv` file from the `sixgroups-finance` bucket to the `sixgroups-finance-archive` bucket.
   - Replace the metadata with the new metadata:
     ```python
     metadata = {"test_meta_key": "test_meta_value"}
     ```

2. **Add Additional Tags to the Copied Object:**
   - Add the following tags to the copied object:
     ```python
     tags = {
         "status": "archived",
         "type": "transaction"
     }
     ```

3. **Run the Code and Verify:**
   - After running the code, check your MinIO console to verify that the object was copied correctly, with the new metadata and tags applied.

---

## Python Code Example

```python
from minio import Minio
from minio.commonconfig import REPLACE, CopySource
from minio.error import S3Error
from minio.commonconfig import Tags

def create_bucket(client, bucket_name):
    try:
        if not client.bucket_exists(bucket_name):
            client.make_bucket(bucket_name)
            print(f"Bucket '{bucket_name}' created successfully.")
        else:
            print(f"Bucket '{bucket_name}' already exists.")
    except S3Error as err:
        print(f"Error: {err}")

def copy_object(client, source_bucket, destination_bucket, source_object, destination_object, metadata):
    try:
        # Copy the object and replace metadata
        result = client.copy_object(
            destination_bucket,
            destination_object,
            CopySource(source_bucket, source_object),
            metadata=metadata,
            metadata_directive=REPLACE
        )
        print(f"File '{source_object}' copied successfully from '{source_bucket}' to '{destination_bucket}'.")
        print(f"Object Name: {result.object_name}, Version ID: {result.version_id}")
        return destination_bucket, destination_object
    except S3Error as e:
        print(f"Failed to copy '{source_object}': {e}")
        return None, None

def set_object_tags(client, bucket_name, object_name, tags):
    try:
        # Apply tags to the copied object
        client.set_object_tags(bucket_name, object_name, tags)
        print(f"Tags {tags} added to object '{object_name}' in bucket '{bucket_name}'.")
    except S3Error as e:
        print(f"Failed to set tags for '{object_name}': {e}")

def main():
    # TODO: Provide your access key & Secret key
    client = Minio(
        "127.0.0.1:9000",
        access_key="your access key",
        secret_key="your secret key",
        secure=False,  # Set to True if using HTTPS
    )

    # TODO: Provide source bucket name
    source_bucket = "sixgroups-finance"

    # TODO: Provide destination bucket name
    destination_bucket = "sixgroups-finance-archive"

    # TODO: Source file name to copy
    source_object = "transaction_log_2023.csv"

    # TODO: Destination file name after copy
    destination_object = "transaction_log_2023.csv"

    # TODO: Define metadata
    metadata = {"test_meta_key": "test_meta_value"}

    # TODO: Define tags
    tags = Tags()
    tags["status"] = "archived"
    tags["type"] = "transaction"

    # Create destination bucket
    create_bucket(client, destination_bucket)

    # Copy file from source bucket to destination bucket
    destination_bucket_name, destination_object_name = copy_object(
        client,
        source_bucket,
        destination_bucket,
        source_object,
        destination_object,
        metadata
    )

    # Add tags to the copied object
    if destination_bucket_name and destination_object_name:
        set_object_tags(client, destination_bucket_name, destination_object_name, tags)

if __name__ == "__main__":
    main()
```

## Part 5: Deleting Outdated Documents

**Problem Statement:**
The Finance department needs to clean up outdated reports and transaction logs to keep the storage organized. They have identified some documents that should be deleted.

**Objective:**
Delete the `transaction_log_2023.csv` and `account_summary_2023.csv` files from the `sixgroups-finance` bucket once they are no longer needed.

---

## Steps

### Step 1: Delete Objects

1. **Delete the Specified Financial Documents:**
   - Delete both `transaction_log_2023.csv` and `account_summary_2023.csv` from the `sixgroups-finance` bucket.

---

## Python Code Example

```python
from minio import Minio
from minio.error import S3Error

def delete_object(client, bucket_name, object_name):
    try:
        # TODO: Use client.remove_object(bucket_name, object_name) to remove object from bucket
        client.remove_object(bucket_name, object_name)
        print(f"File '{object_name}' deleted successfully.")
    except S3Error as e:
        print(f"Failed to delete '{object_name}': {e}")

def delete_multiple_files(client, bucket_name, object_names):
    for object_name in object_names:
        delete_object(client, bucket_name, object_name)

def main():
    # TODO: Provide your access key and secret access key below
    client = Minio(
        "127.0.0.1:9000",
        access_key="your access key",
        secret_key="your secret access key",
        secure=False,  # Set to True if using HTTPS
    )

    # TODO: Name of bucket from where to delete
    bucket_name = "sixgroups-finance"

    # TODO: List of files to delete as provided in the lab
    files_to_delete = [
        "transaction_log_2023.csv",
        "account_summary_2023.csv"
    ]

    delete_multiple_files(client, bucket_name, files_to_delete)

if __name__ == "__main__":
    main()
```

## End of Lab

You have successfully completed Part 5 of the lab, where you deleted outdated financial documents from the  `sixgroups-finance`  bucket using the MinIO Python SDK.
