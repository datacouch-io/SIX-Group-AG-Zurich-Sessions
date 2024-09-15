# Lab 10: Object Locking in MinIO

**Time:** 20 Minutes

## Overview

Object Lock in MinIO is a feature designed to protect objects from being deleted or overwritten for a specified period. It can be used in two modes: Governance Mode and Compliance Mode. Each mode provides a different level of protection, catering to varying needs for data retention and regulatory compliance.

---

## Governance Mode

### Definition:
Governance Mode allows you to protect objects from deletion or modification for a specified retention period. However, in Governance Mode, certain privileged users can bypass the retention settings under specific conditions.

### Use Case:
This mode is suitable for environments where data needs to be protected but might need to be overridden under controlled circumstances, such as correcting errors or reclaiming storage space.

### Example Scenario:
A company has a policy to retain financial records for 7 years. Using Governance Mode, they can ensure these records aren't accidentally deleted during this period. However, if an object was uploaded in error, an administrator with the necessary permissions could reduce the retention period or delete the object before the 7-year period expires.

---

### Step 1: Create a New Bucket with Object Locking

```bash
mc mb --with-lock myminio/sixgroups-governance
```
## Step 2: Set an Object in Governance Mode for 30 Days

1. **Set Object Retention in Governance Mode:**

   - Use the following command to set an object in Governance Mode for 30 days in the `sixgroups-governance` bucket:

     ```bash
     mc retention set --default GOVERNANCE "30d" myminio/sixgroups-governance
     ```

## Step 3: Upload Data to the Bucket

1. **Upload Data:**

   - Upload the `customers.csv` file to the `sixgroups-governance` bucket:

     ```bash
     mc cp /home/training/sixgroups/data/customers.csv myminio/sixgroups-governance
     ```

## Step 4: Try to Delete the Data with the Admin User

1. **Attempt to Delete the Data:**

   - Try deleting the `customers.csv` file from the `sixgroups-governance` bucket using the admin user. You should encounter restrictions due to Governance Mode:

     ```bash
     mc rm myminio/sixgroups-governance/customers.csv
     ```

## Step 5: Create a User with Limited Access

1. **Create a New User:**

   - Create a user with limited access:

     ```bash
     mc admin user add myminio limiteduser limitedpassword
     ```

## Step 6: Create a Custom Policy

1. **Create a Custom Policy File:**

   - Create a custom policy that denies the `bypassGovernanceRetention` action. Save the following JSON as `custom_policy.json`:

     ```json
     {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Action": [
             "s3:GetBucketLocation",
             "s3:ListBucket",
             "s3:ListBucketMultipartUploads"
           ],
           "Effect": "Allow",
           "Resource": [
             "arn:aws:s3:::sixgroups-governance"
           ]
         },
         {
           "Action": [
             "s3:GetObject",
             "s3:PutObject",
             "s3:AbortMultipartUpload",
             "s3:DeleteObjectVersion"
           ],
           "Effect": "Allow",
           "Resource": [
             "arn:aws:s3:::sixgroups-governance/*"
           ]
         },
         {
           "Action": "s3:BypassGovernanceRetention",
           "Effect": "Deny",
           "Resource": [
             "arn:aws:s3:::sixgroups-governance/*"
           ]
         }
       ]
     }
     ```

## Step 7: Apply the Policy to the User

1. **Create and Attach the Policy:**

   - Create the policy and attach it to the limited user:

     ```bash
     mc admin policy create myminio custom_policy custom_policy.json
     mc admin policy attach myminio custom_policy --user limiteduser
     ```

## Step 8: Create a New Alias for the Limited User

1. **Set Up an Alias:**

   - Create a new alias to use the limited user to connect with MinIO:

     ```bash
     mc alias set limiteduser-alias http://localhost:9000 limiteduser limitedpassword
     ```

## Step 9: Try to Remove Files with the Limited User

1. **Attempt to Delete the File:**

   - Attempt to delete the `customers.csv` file using the limited user. You should get an Access Denied error:

     ```bash
     mc rm limiteduser-alias/sixgroups-governance/customers.csv
     ```

---

## Compliance Mode

### Definition:
Compliance Mode is the stricter of the two modes. Once an object is locked in Compliance Mode, it cannot be deleted or modified by any user, including administrators, until the retention period expires. This mode is designed to meet stringent regulatory requirements.

### Use Case:
Compliance Mode is ideal for environments that must adhere to strict regulatory requirements, such as financial institutions or organizations that need to ensure data integrity and immutability over a specific period (e.g., SEC Rule 17a-4).

### Example Scenario:
A healthcare organization needs to retain patient records for 10 years due to legal requirements. Using Compliance Mode, they ensure these records cannot be altered or deleted during this time, even by administrators, ensuring full compliance with legal mandates.

---

## Step 1: Create a New Bucket with Object Locking

1. **Create the Bucket:**

   - Create a new bucket with object locking enabled:

     ```bash
     mc mb --with-lock myminio/sixgroups-compliance
     ```

## Step 2: Set an Object in Compliance Mode for 3 Days

1. **Set Object Retention in Compliance Mode:**

   - Set an object in Compliance Mode for 3 days in the `sixgroups-compliance` bucket:

     ```bash
     mc retention set --default COMPLIANCE "3d" myminio/sixgroups-compliance
     ```

## Step 3: Upload Data to the Bucket

1. **Upload Data:**

   - Upload the `customers.csv` file to the `sixgroups-compliance` bucket:

     ```bash
     mc cp /home/training/sixgroups/data/customers.csv myminio/sixgroups-compliance
     ```

## Step 4: Try to Delete the Data with the Admin User

1. **Attempt to Delete the Data:**

   - Try deleting the `customers.csv` file from the `sixgroups-compliance` bucket using the admin user. The deletion should fail due to Compliance Mode restrictions:

     ```bash
     mc rm myminio/sixgroups-compliance/customers.csv
     ```

---

## End of Lab

You have successfully completed the lab on Object Locking in MinIO using both Governance Mode and Compliance Mode.
