# Lab 9: Working with MinIO Client (mc)

**Time:** 20 Minutes

## Objective

In this lab, you will learn how to use the MinIO Client (mc) for various operations like setting up the client, managing buckets, uploading and downloading objects, and managing policies. By the end of this lab, you will be proficient in using `mc` for interacting with your MinIO server.

---

## Step 1: Configure MinIO Client

1. **Ensure Port Forwarding is Set Up:**

   - Make sure your 9000 port is forwarded to receive traffic:

     ```bash
     kubectl port-forward svc/myminio-hl 9000 -n minio-tenant
     ```

2. **Get Access Key and Secret Key:**

   - Retrieve your access key and secret key from the MinIO Console. If you do not have your existing keys saved, create a new one.
   **![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXc8WHV6uXqu7nA1Zfm50q2v7BD4dcMbZuiQcdkWOZGHmw47vjefCc_2UPrEfmP0vIxYsnyt5d7A-piNeE23C6MuD7y5SGHrQno8_GLJTcNNTgS5-6RPFSeDiH-ZUv2qPw1C3-4myAnLRc3ZgJsRDGIQ8b3Y?key=blwW353dqd07z9jWyDvZYg)**

3. **Set Up an Alias for Your MinIO Server:**

   - Use the `mc alias set` command to configure an alias for your MinIO server:

     ```bash
     mc alias set myminio http://localhost:9000 your_access_key your_secret_access_key
     ```

4. **Verify the Alias:**

   - List all configured aliases to verify that your MinIO server is set up correctly:

     ```bash
     mc alias list
     ```

---

## Step 2: Bucket Management

1. **Create a Bucket:**

   - Create a bucket with the name `sixgroups-admin`:

     ```bash
     mc mb myminio/sixgroups-admin
     ```

2. **List All Buckets:**

   - List all buckets to verify the creation of your new bucket:

     ```bash
     mc ls myminio
     ```

3. **Delete the Bucket:**

   - Delete the `sixgroups-admin` bucket from your MinIO server:

     ```bash
     mc rb myminio/sixgroups-admin
     ```

---

## Step 3: Object Management

1. **Upload a File to a Bucket:**

   - First, recreate the `sixgroups-admin` bucket:

     ```bash
     mc mb myminio/sixgroups-admin
     ```

   - Upload the `/home/training/sixgroups/data/customers.csv` file to the `sixgroups-admin` bucket:

     ```bash
     mc cp /home/training/sixgroups/data/customers.csv myminio/sixgroups-admin
     ```

2. **List All Objects within a Bucket:**

   - List all objects within the `sixgroups-admin` bucket:

     ```bash
     mc ls myminio/sixgroups-admin
     ```

3. **Delete a File from the Bucket:**

   - Delete the `customers.csv` file from the `sixgroups-admin` bucket:

     ```bash
     mc rm myminio/sixgroups-admin/customers.csv
     ```

---

## Step 4: Versioning

1. **Enable Versioning for the Bucket:**

   - Enable versioning for the `sixgroups-admin` bucket:

     ```bash
     mc version enable myminio/sixgroups-admin
     ```

2. **Upload the `customers.csv` File Again:**

   - Upload the `/home/training/sixgroups/data/customers.csv` file to the `sixgroups-admin` bucket:

     ```bash
     mc cp /home/training/sixgroups/data/customers.csv myminio/sixgroups-admin
     ```

   - Run the above upload command multiple times to create multiple versions of the file.

3. **List All Versions of the `customers.csv` File:**

   - List all versions of the `customers.csv` file:

     ```bash
     mc ls --versions myminio/sixgroups-admin/customers.csv
     ```

4. **Delete a Specific Version of the `customers.csv` File:**

   - Choose a version from your version list to delete:

     ```bash
     mc rm myminio/sixgroups-admin/customers.csv --version-id <VERSION_ID>
     ```

---

## End of Lab

You have successfully completed the lab on using the MinIO Client (`mc`) for various operations, including bucket management, object management, and versioning.
