# Lab 4: Defining and Applying Lifecycle Policies with MinIO Console

**Time:** 20 Minutes

## Objective
In this lab, you will learn how to define and apply lifecycle policies using the MinIO Console. Lifecycle policies help you manage your storage by automatically transitioning or expiring objects based on specified rules. You will also create a storage tier and apply transition rules to move objects to this tier.

---

## Step 1: Log in to MinIO Console

1. **Open MinIO Console:**
   - Open your web browser and navigate to the MinIO Console at [https://localhost:9090](https://localhost:9090).
   - Enter the following credentials:
     - **Username:** `minio`
     - **Password:** `minio123`
   - Ensure port-forwarding is active before accessing the console.

---

## Step 2: Navigate to the Desired Bucket

1. **Access the Buckets Section:**
   - Once logged in, click on the "Buckets" option from the left-hand menu to view all available buckets.
   - *Tip:* If you don’t have any buckets, create one before proceeding.

2. **Select Your Bucket:**
   - Choose the bucket where you want to define and apply lifecycle policies by clicking on its name.

---

## Step 3: Access the Lifecycle Management Section

1. **Go to Lifecycle Policies:**
   - On the bucket's overview page, look for the "Lifecycle" option or tab.
   - Click on the "Lifecycle" tab to access the lifecycle policy management interface.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd-ZJxPYrNRiT95ny-nrwgAWtQhXO-lMB-EQMyNYA_mcMPZQup1MPyL8n92aSIcrAxnbci3e6RHl3aHFv8SDceESOXkBm32TAjXA7TY65W0MR3mEcE6-3OA11jQgE-khu-gugNh9RITug5hawwfRzDQBQDR?key=blwW353dqd07z9jWyDvZYg)**
---

## Step 4: Define a New Lifecycle Policy

1. **Create a New Policy:**
   - Click on the "Create Lifecycle Policy" button to define a new lifecycle policy.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdh8AHKpiU8toUC9v61D1FxaETYe0Xkoc66MnD1eIfX_PIPxip-5pLxoSwFtv24eIUhTxUEwnuJxF8rl-uAfsz_bQF76V-ae0wnxqb2rqxbh3f0iWof1DBJZ3M8UDqbNv9vF1427va-q1uGlYx2?key=blwW353dqd07z9jWyDvZYg)**
2. **Set Object Expiration Rules:**
   - Define rules for object expiration. For example, you can set objects to expire after 30 days.
   - Choose whether the rule applies to the current version or non-current versions of objects.
   - You can also specify conditions based on object tags, prefixes, or age.
   - After adding the rule, click "Save."

   **Example Configuration:**
   - **Prefix:** `logs/`
   - **Expiration:** 30 days after creation
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfR09P7GqqnB-kNT7cmmJDOe8JeP_AkiTYn9weVCfGP6ouhkecHtGnGpM8q72tVtZZ8D0AIpIs5Lm2szNfq2JPKgjYyq7GfqJdZYJ2YQfJhN2m1lM8glYuXwpm7dXpJXLrcmAJE5iO3XUfhnRYYdWoJE90?key=blwW353dqd07z9jWyDvZYg)**
3. **Create a Tier (Optional):**
   - *Please Note:* Creating appropriate tiers is typically an administrative task. For the purposes of this lab, we will create a sample tier.
   - Click on "Tiering" in the left-hand side menu and then click on "Create Tier."
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfVvQj9lMPNlGsAUX1V6Oogz3CRj1g4B-kRHk2gn96Hq_VdCKxok3JtpbjN6FhJKoJV4fhFS1A9y68h_KuMjCnt8ZVRY36afCwJLq61BOtw3n-BcYLwlzQ8josTvmlCSwjKb_WlfvR30-fvMQ2tVvrH4rar?key=blwW353dqd07z9jWyDvZYg)**
   - Select "Amazon S3" as the backend to create the tier.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXexyX5lD_iXVjNFxrh5egOkP2JQgAY3kKl9ehOMP9cPTMg1HHWyGjp3sjExqrVy6uEOKjn-CLlIB9tEUS3CU2KDB27OD7KmzhY64m82C0jSRYJkGdEYCW2c5YO09dEvnS-8JawC59gni4wSY88aFFCmKVLR?key=blwW353dqd07z9jWyDvZYg)**
   - Enter the following details to set up S3 as a tier:

     - **Name:** `S3_STANDARD`
     - **Access Key:** `<Access Key>`
     - **Secret Key:** `<Secret Key>`
     - **Bucket Name:** `minio-glacier-storage`
     - **Region:** `North Virginia`
     - **Storage Class:** `Standard`
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcwATSRCwrGPffNXeLoex-rqQaE2-HFLVL7tlBz0Koe_4_8Lef-7_dW6m9JGyNrPHZU1O49YnqJww5GKFuK2FfbKxCbrjXYWPUAcfVZBMEKVl2HXjLnMgBC3ZXhDEIkM97J_E_Mbj1LUfKd08LDTmmWyFHa?key=blwW353dqd07z9jWyDvZYg)**
4. **Set Transition Rules:**
   - Go back to the "Buckets" section by clicking on "Bucket" in the left-hand menu.
   - Click on the bucket name where you want to apply transition rules.
   - Click on "Lifecycle" in the left-hand menu as done in previous steps.
   - Click on "Add Lifecycle Rule" to create transition rules for the bucket.
   - Select "Transition" to define rules to move either the current version or non-current versions to `S3_Tier` after 30 days. This means that after 30 days, your current version will automatically move to the S3 bucket.
**![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXftbenu5UGp-yyQU9p1URa2Aan4-b7LQzljrXtBXHDXxP-V7S0Ph1tSDM0QXri27pU_qqevEROY7UK7ZXIoRkOHCTIlnccwAkbjyKM8xgy7BMO4gfDD2KkhW-VkLWGIi9F4ad-SOJ2Sa8q_N8OiRxpnzI1J?key=blwW353dqd07z9jWyDvZYg)**
   - Optionally, you can add filters to apply these transition rules to specific prefixes or tags. Click on "Filters" to add additional configurations.

   **Example Configuration:**
   - **Prefix:** `archive/`
   - **Transition:** Move to "Glacier" after 90 days

   *Please Note:* Non-current versions (previous versions) of the object are generally not affected by the transition rule unless a separate rule is explicitly applied to them.

---

## End of Lab

You have successfully completed the lab.
