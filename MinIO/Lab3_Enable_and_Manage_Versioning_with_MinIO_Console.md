# Lab 3: Enable and Manage Versioning with MinIO Console

**Time:** 15 Minutes

## Objective
In this lab, you will learn how to enable versioning on a bucket, retrieve and restore previous object versions, delete specific object versions, and access specific versions using the MinIO Console and Python SDK.

---

## Step 1: Enable Versioning on a Bucket Using MinIO Console

1. **Log in to MinIO Console:**
   - Open your web browser and navigate to the MinIO Console at [https://localhost:9090](https://localhost:9090).
   - Enter the following credentials:
     - **Username:** `minio`
     - **Password:** `minio123`
   - Ensure port-forwarding is active before accessing the console.

2. **Navigate to Buckets:**
   - Once logged in, click on the "Buckets" option from the left-hand menu.

3. **Select a Bucket:**
   - Create a new bucket in MinIO where you want to enable versioning.

4. **Enable Versioning:**
   - On the bucket details page, look for the "Versioning" option.
   - Toggle the versioning option to "Enabled."
   - Keep all other settings as default.
   **![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdmy3jJcZrKVtgKa00pHGHLsbO2t08Se_qPDhUKR0J2msY7t0QISq-SdU9tVCNJYh2M28c_6uiOVXntEw72G7dLKYKXOYTcEb0ENosZofEn2pxHlj5j3PgG9e5Yn02bjdlB356vTkUTwp9UScGLqMJ8nr44?key=blwW353dqd07z9jWyDvZYg)**

5. **Confirm Versioning:**
   - Ensure that versioning is enabled for the bucket. You should see a confirmation message or a change in the status.

---

## Step 2: Upload Multiple Versions of an Object Using MinIO Console

1. **Upload an Initial Object:**
   - Go to the Object Browser and select your versioned bucket.
   - Use the "Upload" button to select and upload your file, e.g., `/home/sixgroups/data/customers.csv`.

2. **Upload a New Version of the Object:**
   - Modify the content of `customers.csv` on your local system.
   - Upload the modified file with the same name (`customers.csv`) to the same bucket. This action will create a new version of the object.

---

## Step 3: Retrieve and Restore Previous Versions Using MinIO Console

1. **Access Object Versions:**
   - Navigate to the object (`customers.csv`) within the bucket.
   - Click on the object name to view its details.
   - Under the "Actions" tab, click on "Display Object Versions" to see all versions of the object.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXctV9Cec9y2coQj7XrRl307fSJ-DmImIc3qmXqPgU76K3KMLs6jvkjxPDiuSz9DYB93ulMqrgMYmX6kMAk7rcVTcOGFzPL_eOMDAaM9JUaGpjLjWxZGf9WQ4_j4QIuOIUdy5tS61DnJLTZPx5zpAVne7S4?key=blwW353dqd07z9jWyDvZYg)**
   - *Note:* Since you have uploaded the file twice, you should see two versions with different version IDs.
   **![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXe_iRge4VHrHlOlegWGvvrDqx-H7g5yIhTX9I4IL_ymUSx-zR-Mq7BtfsVm4Qg_0QmQeYA_EdxNyzI7rVchaLkO9K9vO2gnAZYpUguQCrgXK2qWVO-xzcQvFIRXWnpDRKweN_pMn38jcJhWFFCQMUhmR5Xr?key=blwW353dqd07z9jWyDvZYg)**

2. **Restore a Previous Version:**
   - Select an older version of the object.
   - Use the "Restore" icon to restore the previous version.
   **![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXftPgIkhX6BK_EpXK2oLUHg_Rbom5xncI7MhX6ePwH2lUhWf61d0IPT0DzHhYUGwEYePkSzmqiGe1I8v_z8V5m9XrpEvgMK-Iwmr_8Bk7lWmeZBx-vYnjceBhD1N0N00s6X5nFfpT5UwZifP-jMdCbuyV8?key=blwW353dqd07z9jWyDvZYg)**
   - As you restore, you will notice a new version added to the list.
   **![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfCPNKj4M5_FODzGVs4Us_VX0pYGM10wSiSGHVboBSCsFy_GjyWPXp3d7x7_IkCluuLIKVoWe40-OKIB5yUA6OIajxoWO6KTtdiTOAWzS43qoQPdc_Oy_rHVg1A421ZEwvzJGKQjnrTTczM-PF-nqHUteyI?key=blwW353dqd07z9jWyDvZYg)**

3. **Download a Specific Version:**
   - Use the "Download" icon to download a specific version of the object.
   **![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdktwBJ6igop9iH9QdJGn_mUy6ZC1G0Ik3pbd0FSe2lHT2b48ESpYTPosUjWyUIZ2NVJlVO3saXl3zdR1WAhHLJke4iw0yTbq_uJmPFwju5jENNJP4OUgxKCRgxXP0kiMIxUg2O0pEKcUCSNEXK3rXt-bw?key=blwW353dqd07z9jWyDvZYg)**

4. **Delete a Specific Version:**
   - Click on the version name that you want to delete.
   - Click the "Delete Version" option in the right-side menu.
   **![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeZZWJX_GJ4S8IiAXnE0xImSlNyPo6FYt_K2TbyKz60JIV_v4IP3HqME_ovEgg1U8F3SlIqbotaUyAEXhENfEN3iC_KPw6TwchCdXR-zvWaVVcoqQcrdmxf28fQlC8nw8eUJMidZBxXKgIHjtZVMVnCwNA?key=blwW353dqd07z9jWyDvZYg)**
   - **Confirm Deletion:**
     - Ensure that the version has been deleted by checking the list of remaining versions.

---

## Step 4: Delete a Versioned Bucket

1. **Delete the Bucket:**
   - Click on the bucket from the left-hand side menu.
   - Select the versioned bucket and click on "Delete Bucket."
   - If the bucket contains versions, you will see an error message indicating that you must delete all versions before deleting the bucket.
   **![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXceSRAIMjH4xbhrAPeeq2q5855JxYjGnptcStJMISyokOPgtKlm3_D5mbYrMd9Q90r6srXgFqmDZxsAnry3ZgTMhBLuGI0LnTPJWBIymM7YUwL9VkrKXciczcueOHheliFS_G5CDrjvx6Ctoc148u5ee6gK?key=blwW353dqd07z9jWyDvZYg)**

2. **Delete All Versions of the Object:**
   - Click on the Object Browser again from the left-hand side menu.
   - Go to the versioned bucket and click on `customers.csv`.
   - Click on "Delete."
   **![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXchRiKXml3gSEyGcw4SfDNSr-3Il8AZMbiNkvCbdFaKGMhFN2_fqJwSvLu0TYyJdselWXSsemBZOYKDkwXuAjeoYggF4z5D9ewTcC4KmKp7zB4iunqqq7jmPsbHRt6Nql2nisfv5SvyXv0Q-UU4YRhhWc-s?key=blwW353dqd07z9jWyDvZYg)**
   - You will get a prompt to confirm whether you want to delete only the current version or all versions. Enable the checkbox to delete all versions, then press "Delete."
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXctKp9MjVqk4n9uxtSFpIqAgxepAu21mWkmoVL2uXU-sXoLzqVvQooWKFDtiZ8Zu6aBfwgD5jAiSd3u6c0W93XQJK_NLIkKrpI9_FFZLlwmFfT9MuKQwsQ9_ECHF2luXZaP7JH8KUXFmixxJXv8yzUCh-LA?key=blwW353dqd07z9jWyDvZYg)**
3. **Retry Bucket Deletion:**
   - Once all object versions are deleted, repeat the previous step to delete the bucket.

---

## End of Lab

You have successfully completed the lab.
