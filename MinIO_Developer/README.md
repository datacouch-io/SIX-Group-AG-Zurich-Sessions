# MinIO Labs Series

## Overview

This repository contains a series of labs designed to help you gain hands-on experience with MinIO, a high-performance, distributed object storage system. These labs cover a wide range of topics, from basic bucket and object management to advanced features like versioning, object locking, and the use of the MinIO Client (`mc`).

## Lab Contents

### [Lab 1: Start Minikube and Run MinIO Cluster using MinIO Operator](Lab1_MinIOCluster.md)
- **Time:** 15 minutes
- **Objective:** Start a Minikube cluster and install the MinIO Operator using Helm. Deploy a MinIO Tenant and verify the setup using the MinIO Console.

### [Lab 2: Common API Operations using MinIO Console](Lab2_CommonAPIOperations.md)
- **Time:** 15 minutes
- **Objective:** Use the MinIO Console to perform basic operations like uploading, downloading, and deleting files within a bucket.

### [Lab 3: Enable and Manage Versioning with MinIO Console](Lab3_Versioning.md)
- **Time:** 15 minutes
- **Objective:** Enable versioning on a bucket, upload multiple versions of an object, and manage these versions using the MinIO Console.

### [Lab 4: Defining and Applying Lifecycle Policies with MinIO Console](Lab4_LifecyclePolicies.md)
- **Time:** 20 minutes
- **Objective:** Define and apply lifecycle policies to manage the retention and deletion of objects in a MinIO bucket.

### [Lab 5: Access Management with MinIO](Lab5_AccessManagement.md)
- **Time:** 20 minutes
- **Objective:** Create, define, and apply access policies for users or groups using the MinIO Console. Test and verify these policies.

### [Lab 6: Bucket Operations with Python SDK](Lab6_BucketOperations_PythonSDK.md)
- **Time:** 25 minutes
- **Objective:** Perform bucket operations such as creating, listing, and deleting buckets using the MinIO Python SDK.

### [Lab 7: Object Operations for Financial Data Using MinIO Python SDK](Lab7_ObjectOperations_FinancialData.md)
- **Time:** 25 minutes
- **Objective:** Implement a Python application to manage financial documents, including uploading, listing, and downloading objects, as well as managing object versions.

### [Lab 8: Versioning in MinIO using Python SDK](Lab8_Versioning_PythonSDK.md)
- **Time:** 20 minutes
- **Objective:** Enable versioning on a bucket, upload multiple versions of an object, and manage versions using the MinIO Python SDK.

### [Lab 9: Working with MinIO Client (mc)](Lab9_WorkingWith_MC.md)
- **Time:** 20 minutes
- **Objective:** Use the MinIO Client (`mc`) to manage buckets, objects, and policies, including versioning and object retention.

### [Lab 10: Object Locking in MinIO](Lab10_ObjectLocking.md)
- **Time:** 20 minutes
- **Objective:** Learn how to use object locking in MinIO to protect objects from being deleted or modified, using both Governance and Compliance modes.

## Prerequisites

- **Minikube** installed and running.
- **kubectl** installed and configured.
- **MinIO Client (mc)** installed.
- **Python 3.x** installed, with necessary libraries for using the MinIO Python SDK.
