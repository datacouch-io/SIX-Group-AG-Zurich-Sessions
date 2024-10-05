# Lab 6: Bucket Operations with Python SDK

**Time:** 25 Minutes

## Objective
Participants will learn how to create, list, and remove buckets in MinIO using the Python SDK by solving real-world scenarios relevant to your company. The lab will be structured around practical tasks that the company might encounter in its day-to-day operations.

---

## Scenario 1: Creating Buckets for Departmental Data Storage

**Problem Statement:**
Six Groups is expanding, and each department needs its dedicated storage space in MinIO. Your task is to create individual buckets for the following departments:
- Marketing
- IT
- Finance
- HR

Each bucket should follow a specific naming convention: `company-department` (e.g., `sixgroups-marketing`, `sixgroups-finance`, etc.).

---

## Steps

### Step 1: Generate Access & Secret Key

1. **Connect to the MinIO Console:**
   - Ensure port forwarding is active before opening the link.
   - Open your web browser and navigate to the MinIO Console at [https://localhost:9090](https://localhost:9090).
   - Enter the following credentials:
     - **Username:** `minio`
     - **Password:** `minio123`

2. **Create an Access Key:**
   - Click on "Access Key" from the left side menu.
   **![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcAgSo7qUA3FDWDTIlj64SDtg-m7VplEoAgG4E9NWAmyykdfz4ANYGCXWSNChPigJa9kd00xbEllql8cD0gugFTHA540F2aB4R9f27RREKN8aEUQdEi8hJHKp9sKm19A-CpAtVMlKXvcDNyXrCSY5-Iu7QG?key=blwW353dqd07z9jWyDvZYg)**
   - Click on "Create Access Key."
   - Add the required details and click "Save."
   - Make sure to copy and store the access keys and secret access keys securely, as you will use them in your Python code.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeREOmDSpoJgmgGBBjyY9RF1pvDLhXzqxuz2snhnzWES4RywWxpDtC0fo2Gh5_8EQE_FPkahdt-3sRwsD_SpPfVdw7nV7e3747rWgRJ_EzF1XPUdo_BPG7h90XtR7beuzmIDIGwqUcxROZgeO3AlVBH7J2F?key=blwW353dqd07z9jWyDvZYg)**
---

### Step 2: Make MinIO Service Available

1. **Port-Forwarding for MinIO Service:**
   - Open a new terminal and perform port-forwarding for port 9000:

     ```bash
     kubectl port-forward svc/myminio-hl 9000 -n minio-tenant
     ```

---

### Step 3: Run Python Code to Create Multiple Buckets

1. **Locate the Python Code:**
   - Navigate to the following location in your file system to find the Python code:
     `minio_developer/labs/Lab6_Bucket_Operations/challenge/create_multiple_buckets.py`

2. **Initialize the MinIO Client:**
   - Connect to the MinIO server using the Python SDK with the provided access key and secret key.

3. **Create the Buckets:**
   - Complete the TODO sections in the code to create buckets for each department following the naming convention (e.g., `sixgroups-marketing`, `sixgroups-finance`, etc.).

4. **Verify Bucket Creation:**
   - Use the MinIO Console to verify that the buckets have been created successfully.

---

## Python Code Example

```python
from minio import Minio
from minio.error import S3Error

def main():

    # TODO: Provide your Access Key and Secret Access Key
    client = Minio(
        "127.0.0.1:9000",
        access_key="your_access_key_here",
        secret_key="your_secret_access_key_here",
        secure=False,  # Set to True if using HTTPS
    )

    # TODO: Change the bucket names as required
    bucket_names = ["sixgroups-marketing", "sixgroups-it", "sixgroups-finance", "sixgroups-hr"]

    for bucket_name in bucket_names:
        try:
            # TODO: Check if the bucket already exists
            if not client.bucket_exists(bucket_name):
                # TODO: Create a new bucket if it does not exist
                client.make_bucket(bucket_name)
                print(f"Bucket '{bucket_name}' created successfully.")
            else:
                print(f"Bucket '{bucket_name}' already exists.")
        except S3Error as err:
            print(f"Error creating bucket '{bucket_name}': {err}")

if __name__ == "__main__":
    main()
```

## Scenario 2: Listing All Buckets to Audit Storage

**Problem Statement:**
The IT department at Six Groups needs to perform a regular audit of all existing buckets to ensure compliance with company policies. Your task is to list all the buckets currently stored in MinIO.

---

## Steps

### Step 1: Initialize the MinIO Client

1. **Use the Same Initialization as in Scenario 1:**
   - Reuse the initialization code from Scenario 1 to connect to the MinIO server using the Python SDK with the provided access key and secret key.

### Step 2: List All Buckets

1. **Write a Python Script:**
   - Write a Python script that retrieves and displays a list of all buckets in the MinIO instance.

2. **Documentation:**
   - Document the results, noting down the total number of buckets and their names.

---

## Python Code Example

```python
from minio import Minio
from minio.error import S3Error  # Correct import for error handling

def main():
    # TODO: Provide your Access Key and Secret Access Key
    client = Minio(
            "127.0.0.1:9000",
            access_key="your_access_key_here",
            secret_key="your_secret_access_key_here",
            secure=False,  # Set to True if using HTTPS
        )
    try:
        # TODO: List all buckets and save it in bucket variable
        # API to list all buckets -- client.list_buckets()
        buckets = client.list_buckets()  # Assign the result of list_buckets to a variable

        print("Existing buckets:")
        for bucket in buckets:
            print(bucket.name)

    except S3Error as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()
```

## Scenario 3: Removing Obsolete Buckets

**Problem Statement:**
Six Groups has decided to discontinue a few projects, and the associated departmental data is no longer needed. Your task is to remove the following obsolete buckets:
- `sixgroups-marketing`
- `sixgroups-hr`

---

## Steps

### Step 1: Initialize the MinIO Client

1. **Use the Same Initialization as in Previous Scenarios:**
   - Reuse the initialization code from previous scenarios to connect to the MinIO server using the Python SDK with the provided access key and secret key.

### Step 2: Remove Specific Buckets

1. **Write a Python Script:**
   - Write a Python script to delete the specified buckets (`sixgroups-marketing` and `sixgroups-hr`).

### Step 3: Verification

1. **List All Buckets Again:**
   - After deletion, list all buckets to confirm that the obsolete buckets have been removed.

---

## Python Code Example

```python
from minio import Minio
from minio.error import S3Error

def main():
    try:
        # TODO: Provide your Access Key and Secret Access Key
        client = Minio(
            "127.0.0.1:9000",
            access_key="your_access_key",
            secret_key="your_secret_access_key",
            secure=False,  # Set to True if using HTTPS
        )

        # TODO: List of bucket names to delete as given in lab
        bucket_names_to_delete = ["sixgroups-marketing", "sixgroups-hr"]

        for bucket_name in bucket_names_to_delete:
            try:
                # TODO: Delete the bucket using client.remove_bucket(bucket_name) API
                client.remove_bucket(bucket_name)  # Remove the bucket
                print(f"Bucket '{bucket_name}' deleted successfully.")
            except S3Error as e:
                print(f"Error deleting bucket '{bucket_name}': {e}")
            except Exception as e:
                print(f"An error occurred while deleting '{bucket_name}': {e}")

    except S3Error as e:
        print(f"MinIO error: {e}")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()
```

## Scenario 4: Adding and Retrieving Bucket Tags

**Problem Statement:**
Six Groups wants to categorize their buckets with metadata for easier management and searching. Your task is to add tags to the `sixgroups-it` bucket that indicate the bucket's purpose and owner. After adding the tags, retrieve them to verify they were correctly applied.

---

## Steps

### Step 1: Initialize the MinIO Client

1. **Use the Same Initialization as in Previous Scenarios:**
   - Reuse the initialization code from previous scenarios to connect to the MinIO server using the Python SDK with the provided access key and secret key.

### Step 2: Add Bucket Tags

1. **Write a Python Script to Add Tags:**
   - Add tags such as `{"purpose": "infrastructure", "owner": "IT Dept"}` to the `sixgroups-it` bucket.

### Step 3: Retrieve and Verify Tags

1. **Retrieve and Print Tags:**
   - Retrieve and print the tags of the `sixgroups-it` bucket to ensure they were correctly applied.

---

## Python Code Example

```python
from minio import Minio
from minio.error import S3Error  # Correct import for error handling
from minio.commonconfig import Tags

def main():
    try:
        # TODO: Provide your Access Key and Secret Access Key
        client = Minio(
            "127.0.0.1:9000",
            access_key="your access key",
            secret_key="your secret key",
            secure=False,  # Set to True if using HTTPS
        )

        tags = Tags()
        # TODO: Add your tags here
        tags["purpose"] = "infrastructure"
        tags["owner"] = "IT Dept"

        # TODO: Use client.set_bucket_tags("bucket-name", tags) API to apply the tags
        client.set_bucket_tags("sixgroups-it", tags)
        print("Tags added to bucket.")

        # TODO: Use client.get_bucket_tags("bucket-name") API to retrieve the tags
        retrieved_tags = client.get_bucket_tags("sixgroups-it")

        # Print the retrieved tags
        for tag_key, tag_value in retrieved_tags.items():
            print(f"{tag_key}: {tag_value}")

    except S3Error as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()
```

## End of Lab

You have successfully completed the lab on adding and retrieving bucket tags using the MinIO Python SDK.
