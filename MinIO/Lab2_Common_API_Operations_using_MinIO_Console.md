# Lab 2: Common API Operations using MinIO Console

**Time:** 15 Minutes

## Objective
In this lab, you will use the MinIO Console to perform basic operations such as uploading files to a bucket, downloading them, deleting them, and listing all objects within the bucket. You will verify each operation by checking the presence or absence of the files in the bucket.

---

## Step 1: Access MinIO Console

1. **Open MinIO Console:**
   - Launch your web browser.
   - Navigate to the URL where your MinIO Console is hosted: [https://localhost:9090](https://localhost:9090).
   - Enter the credentials:
     - **Username:** `minio`
     - **Password:** `minio123`

2. **Ensure Port-Forwarding is Active:**
   - Make sure port-forwarding is done before attempting to access the console.

---

## Step 2: Create a Bucket

1. **Navigate to the Buckets Section:**
   - Once logged in, click on the "Buckets" tab in the sidebar.

2. **Create a New Bucket:**
   - Click the "+ Create Bucket" button.
   - Provide a unique name for your bucket (e.g., `my-first-bucket`).
   - Leave all other settings as default.
   - Click "Create Bucket."
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdJGfExDlsCKbFdcwBncBL8QXCzhsKoaB9Fqq59e9d8SZbMdVtP3q1AIf20KBoW4IWn_cB6NgOFekszGBL-UbqOTD2KwM2DMuo-DIq6rEwaRL2LOlfwgazBjIX5iwTkzm1GOv0VaApVRJg4d0wXHwpR0mSQ?key=blwW353dqd07z9jWyDvZYg)**
---

## Step 3: Upload Files to the Bucket

1. **Navigate to Your Bucket:**
   - Click on "Object Browser" on the left side of your screen.
   - Select the bucket you just created (e.g., `my-first-bucket`).
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXea5XE1To_wTB-dstJ5NPF8U88XTio6solJK4iKtEYwI0CbyS9meutXGohKqCY-QCxBo44Sc1aB3VrxDOABNtHraYVlOQALl_rBzb8hvdcgV-F-TQA7f7Pe-T4xVNhnBK3qlyGnmFKnytYNZzuCbThBMDw8?key=blwW353dqd07z9jWyDvZYg)**
2. **Upload Files:**
   - Click the "Upload" button.
   - In the file upload dialog, click "Browse" and select the file(s) you want to upload.
   - After selecting the files, click "Upload" to add them to your bucket.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXf5aUmD5W6q1iCMHKIWmw1qgxPkTTwWn33JC2br6_AOHS3X58N_EYxkM6bSDt-x8M_uMR1gvUahcUeIgHNttjyoAEu3DjuRIJ5JYDTwSswguiPvIk5hdnt3GGzV_YnbrD6TLf2DvrufD8PlZKAtOHhRFBDX?key=blwW353dqd07z9jWyDvZYg)**
3. **Verify Upload:**
   - Ensure that the uploaded files appear in the bucket list, indicating successful upload.

---

## Step 4: Download Files from the Bucket

1. **Download Files:**
   - In the bucket view, locate the file you want to download.
   - Click on the file to open its options, and select "Download."
   - Save the file to your local system.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfQSehSGlZwOl-JRJnKcj8sKCmh8z0BjnWX6b0iYNX4pYk2WSGKD2Zw7eK5gdF7SSsEXBAnCMG5NmgILIEPeknNBM4UfGDeXygpbatEpp5PXRonZtkx9awvOnnMZCJx4_sL9lP7sfDryXoSySWd3sCG4zqw?key=blwW353dqd07z9jWyDvZYg)**
2. **Verify Download:**
   - Check your local system to ensure the file has been downloaded and is accessible.

---

## Step 5: Delete Files from the Bucket

1. **Delete Files:**
   - In the bucket view, select the file(s) you want to delete.
   - Click on the "Delete" option.
   - Confirm the deletion in the dialog that appears.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd3kXj4UUSoOj-s2h-_Al84mnn_c1_o3yAhUg9iA0XOzZACxAMfTs3ZDBDigprcI0LRwU6FauCgXnb8eoPwReK7UpggBBAbhers6AAg0iue1Sh-SSMtE1RFN2B_W6MY9undFnjIJ6eYEzbyVcuppTM-Sss?key=blwW353dqd07z9jWyDvZYg)**
2. **Verify Deletion:**
   - Ensure that the deleted file(s) no longer appear in the bucket list.

---

## Step 6: Delete a Bucket

1. **Go to Bucket View:**
   - In the sidebar, click on the "Buckets" tab to view all buckets.

2. **Delete a Bucket:**
   - Select the bucket you want to delete.
   - Click on "Delete Bucket."
   - Confirm the deletion in the dialog that appears.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd74OPV49mIBtYp1tjeq9pIH0i36Tm_422s65r1aAnVJrdvuMgujHd6d2wITcmir5HqHrkQ4Vtazwvn2EZ3ayBcJes5Ev2rt1NiYbg0og4ij-bhVqTMtNuifT7pf5pZeMzfz1kXxHOEwVDGvuiWpnrHm334?key=blwW353dqd07z9jWyDvZYg)**
3. **Verify Deletion:**
   - Ensure that the deleted bucket(s) no longer appear in the bucket list.

---

## End of Lab

You have successfully completed the lab.
