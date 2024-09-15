# Lab 5: Access Management with MinIO

**Time:** 20 Minutes

## Objective
In this lab, you will learn how to create, define, and apply access policies in JSON format for users or groups using the MinIO Console. You will also verify and manage these policies by testing access and making adjustments as needed.

---

## Step 1: Access MinIO Console

1. **Log in to MinIO Console:**
   - Open your web browser and navigate to the MinIO Console at [https://localhost:9090](https://localhost:9090).
   - Enter the following credentials:
     - **Username:** `minio`
     - **Password:** `minio123`

---

## Step 2: Create a New User or Group

1. **Navigate to the Identity and Access Management (IAM) Section:**
   - Once logged in, click on the "Identity" option from the left-hand menu.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdvxob6y-OmC5XyUZ6zluX7iVcUwLMMt7O5iTGg10CRLoSMYjzyfLJUr77xCOs7NC2Ya9D6eMAucGBN_ernM1TXd7E2LhBbqZASWuYOLG04uDeqOBOFG5hp9TDgjxjW6Rvkd_p9clBL23WapkEJGDmGQycA?key=blwW353dqd07z9jWyDvZYg)**
2. **Create a New User:**
   - Click on "Users" in the IAM section.
   - Create a new user with **read-only** access.
   - Enter the necessary details such as username and password.
   - Click the “Save” button to create the user.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfyZZwDJC49q00_xSWTRXUlbNLgF_rNAiLTPak6lbrRCFTs937CMnNONpMO5r31Y4gXvypPqdcVdUwlg_GApVPjE5XpDDQJCTKDVzxotWoQx99KkIeEO0cM7PTk56aKOeYt9VA8kg6IroIzCXhWK_Q8k2sJ?key=blwW353dqd07z9jWyDvZYg)**
3. **Log in with the New User:**
   - Sign out of the current session.
   **![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXf0H1xUWWAHXcj2jeCHujlPS4HSu-Bm4SnmvinV8TpIIRc32vVOPMsXybc16dM-_6BL1scoWdRs-mURZGTSicMxFep3y8Mv3zzcjiQlDKXemJjs6tsI_uK1AacgIxN1le2MUeV2mbCG5pyGSoX1QiWyVYS3?key=blwW353dqd07z9jWyDvZYg)**
   - Log in using the newly created user credentials.
   - **Limited Access:** After logging in, observe that the new user has limited permissions. For example, the user cannot create new buckets, and certain UI elements such as Events, Tiering, and Site Replication are not available.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXexyXAvpyDztJ7oue4xfuWiF69EeilSibDTk456zkUqV7q0LkORynHtApXRSpPnW_ZsdzoEShvSeBux8HP4TUsezg-fs5pTA5qEFUm4ycApr4kwmULT7M7Y9_94dNcAL_AdIRgCb_U2ukJ7Pqk1JKMx6b5H?key=blwW353dqd07z9jWyDvZYg)**
4. **Return to the Admin User:**
   - Sign out again and log back in using the original console user credentials:
     - **Username:** `minio`
     - **Password:** `minio123`

5. **Create a New Group:**
   - Click on "Groups" in the IAM section of the left-hand menu.
   - Enter the necessary details such as group name.
   - Add users to this group by selecting existing users and assigning them to the group.
   - Click on "Create Group" to save the group.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfSo6aPS-Q3RWGBFxqs_gvtaUYlq7tKoVDkdTlrtxlZ_A_-pNYUTZSF5wxuUQSk3nMdiZ9Yf_xsOc_QyMcB8LrKLVLnIjEW0GkHL9ddBkV2rCF_R4et2CLJKQF-JQZFgl91Rn_Z_RXysjWc-XRNjV7ir5Wb?key=blwW353dqd07z9jWyDvZYg)**
   *Tip:* When creating a group, you can add multiple users to it, and any policies applied to the group will apply to all its members.


## Step 3: Define an Access Policy in JSON Format

1. **Navigate to Policies:**
 - Click on "Policies" in the left-hand menu to define access policies.
 - You will notice that there are some pre-existing policies that you can use.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd-KcJ6qKzSHRaPsTdK3kcMKQa6yGcOwQOt78H96nFc_PUStqTroCxxWd4JAfEFjnSQBS6GjPV7qmRBXkvy6-QITbM_2ECsNi94g_yn1JuSqdPbCiWbg3XB1CsmOec0wVLNEtZOgAg7roMlZknS0nzxNDKU?key=blwW353dqd07z9jWyDvZYg)**
   *Tip:* Policies control what actions users or groups can perform on specific buckets and objects.

2. **Create a New Policy:**
 - Click on the "Create Policy" button.
 - Provide a name for the policy that reflects its purpose (e.g., `Read-Only-Access`).

   *Tip:* Use descriptive names for policies to easily identify their function.

3. **Write the Policy in JSON Format:**
 - Define the policy in JSON format. For example, a read-only policy for a specific bucket might look like this. Replace `your_bucket_name` with the actual bucket name:

 ```json
     {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Action": [
             "s3:GetObject",
             "s3:ListBucket"
           ],
           "Resource": [
             "arn:aws:s3:::your_bucket_name",
             "arn:aws:s3:::your_bucket_name/*"
           ]
         }
       ]
     }
```

   *Tip:* Ensure the `Resource` field correctly points to the bucket and objects you want the policy to apply to.

4. **Save the Policy:**
 - After writing the JSON policy, click "Save" to store it in the MinIO Console.

---

## Step 4: Apply the Policy to a Group

1. **Assign the Policy:**
 - Go back to the Identity section, and under "Groups," select the group to which you want to assign the policy.
 - Click on "Set Policy" and select the policy you created.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXey4_D1cvcdmQVsqvDpZ-EIt9LNHHp47cIM8LN6eGo1ONKBGraputT0xjKJQ8Aigqzh4A33gQ9ziaeRVHCA2N0pOwUybowXBsiOIhycthk5RppdpZsvDc9qcdBma3ZpQ4sr2ISDNegoWgVP4SlW4OQgOrvn?key=blwW353dqd07z9jWyDvZYg)**
   *Tip:* Multiple policies can be attached to a user or group, and they will have the combined permissions of all attached policies.

2. **Confirm the Policy Application:**
 - Ensure that the selected policy appears in the list of attached policies for the user or group.

---

## Step 5: Test Access Based on the Applied Policy

1. **Test User or Group Access:**
 - Log in to the MinIO Console or use the MinIO Client (mc) with the credentials of the user for whom the policy was applied.
 - Attempt to perform actions (like uploading, downloading, or listing objects) that are permitted or restricted by the policy.

2. **Verify Policy Enforcement:**
 - Ensure that the user or group can only perform the actions allowed by the policy.
 - If an action is restricted by the policy, the user should receive an access denied error.

---

## Step 6: Manage and Adjust Policies

1. **Review and Modify Policies:**
 - Log back in with the console user.
 - Return to the "Policies" section to review any existing policies.
 - If adjustments are needed, edit the JSON policy, save the changes, and re-test the access.

2. **Detach Unused Policies:**
 - If a policy is no longer needed, detach it from the user or group, or delete it entirely from the "Policies" section.

   *Tip:* Keep your policy list clean and organized by removing obsolete policies.

---

## End of Lab

You have successfully completed the lab on access management using the MinIO Console.
