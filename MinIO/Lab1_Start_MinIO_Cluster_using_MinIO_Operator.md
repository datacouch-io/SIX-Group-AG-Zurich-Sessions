# Lab 1: Start Minikube and Run MinIO Cluster using MinIO Operator

**Time:** 15 Minutes

## Lab Summary
In this lab, participants will set up a Minikube cluster and deploy a MinIO cluster using the MinIO Operator. The MinIO Operator simplifies the deployment, management, and scaling of MinIO clusters in Kubernetes environments. Participants will learn how to start a Minikube cluster, install the MinIO Operator using `kubectl`, and deploy a MinIO cluster by creating a MinIO tenant. Additionally, participants will verify the deployment, check the running services, and access the MinIO web interface.

---

## Step 1: Start Minikube

1. **Ensure Your System Meets the Requirements:**
   - Make sure your system has sufficient resources: at least 4 CPUs and 8 GB of memory are recommended.
   - Ensure you have Minikube installed. If not, follow the [Minikube installation guide](https://minikube.sigs.k8s.io/docs/start/) to set it up.

2. **Start the Minikube Cluster:**

    Open a terminal and execute the following command to start Minikube with the required resources:

    ```bash
    minikube start --cpus 4 --memory 8192
    ```

    This command initializes a Kubernetes cluster on your local machine with 4 CPUs and 8 GB of memory, which is sufficient to run MinIO.

3. **Wait for Minikube to Start:**

    The startup process may take a few minutes. During this time, Minikube is creating a virtual machine, setting up a Kubernetes cluster, and configuring the necessary network settings.

---

## Step 2: Verify Minikube is Running

1. **Check the Status of the Minikube Cluster:**

    Once Minikube has started, verify that it is running correctly by executing:

    ```bash
    minikube status
    ```

    You should see output indicating that the cluster is running, and components like `kubelet` and `apiserver` are active. If any component is not running, troubleshoot based on the error messages provided.

---

## Step 3: Install the MinIO Operator

1. **Install the MinIO Operator Using `kubectl`:**

    The MinIO Operator simplifies the deployment of MinIO in Kubernetes by managing CRDs (Custom Resource Definitions) for MinIO-specific resources like tenants, buckets, and consoles.

    Execute the following command to apply the MinIO Operator to your Kubernetes cluster:

    ```bash
    kubectl apply -k "github.com/minio/operator?ref=v6.0.2"
    ```

    This command fetches the MinIO Operator from the specified version (`v6.0.2`) and applies it to your cluster, setting up the necessary CRDs and controllers.

2. **Wait for the Operator to Deploy:**

    The MinIO Operator will take a few moments to deploy. It creates several resources in the `minio-operator` namespace, including Pods that run the operator and its associated components.

---

## Step 4: Navigate to the Lab Directory

1. **Navigate to the Lab1 Directory Where the Tenant YAML is Located:**

    Change your current directory to where the lab files are located:

    ```bash
    cd sixgroups/minio_developer/labs/Lab1_MinioSetup
    ```

    This directory contains the `tenant.yaml` file that defines the configuration for deploying a MinIO cluster (tenant) using the MinIO Operator.

---

## Step 5: Deploy a MinIO Cluster Using the Tenant YAML File

1. **Review the `tenant.yaml` File (Optional):**

    Before deploying, you might want to open the `tenant.yaml` file in a text editor to understand the configuration. This file defines the number of MinIO instances (servers), the storage configuration, access credentials, and other parameters required to deploy a MinIO cluster.

2. **Apply the `tenant.yaml` File to Create a MinIO Tenant:**

    Deploy the MinIO cluster by running:

    ```bash
    kubectl apply -f tenant.yaml
    ```

    This command creates a new MinIO tenant in the Kubernetes cluster. The MinIO Operator will manage this tenant by creating the necessary StatefulSets, Pods, Services, and Persistent Volume Claims (PVCs) based on the specifications in the `tenant.yaml` file.

---

## Step 6: Verify the MinIO Tenant Deployment

1. **Check the Status of the MinIO Tenant:**

    Use the following command to verify that the MinIO tenant has been successfully created:

    ```bash
    kubectl get tenants -n minio-tenant
    ```

    The output should show the tenant with a status of `Ready` or `Running`. If the tenant is not ready, check the events or logs for troubleshooting.

---

## Step 7: Check Running Pods and Services

1. **List All Resources in the `minio-tenant` Namespace:**

    Once the tenant is ready, you can list all the Kubernetes resources (Pods, Services, PVCs, etc.) that were created as part of the MinIO deployment:

    ```bash
    kubectl get all -n minio-tenant
    ```

    This will display the state of all resources in the `minio-tenant` namespace, allowing you to verify that everything has been set up correctly. Look for running Pods and Services with the appropriate names.

---

## Step 8: Access MinIO

1. **Retrieve MinIO Service Details and Perform Port Forwarding:**

    To access the MinIO web interface, you need to forward the port from the MinIO console service to your local machine:

    ```bash
    kubectl get svc -n minio-tenant
    kubectl port-forward svc/myminio-console 9090 -n minio-tenant
    ```

    This command forwards port `9090` on your local machine to the MinIO console service running in the Kubernetes cluster. Keep this terminal open to maintain the port forwarding session.

2. **Access the MinIO Web Interface:**

    Open a web browser and navigate to the following URL:

    ```plaintext
    https://localhost:9090
    ```

    You should see the MinIO login page. Use the following credentials to log in:

    - **Username:** `minio`
    - **Password:** `minio123`

    After logging in, you will have access to the MinIO dashboard, where you can manage your object storage.

---

## End of Lab

You have successfully completed the lab. You have learned how to start a Minikube cluster, install the MinIO Operator, deploy a MinIO tenant, and access the MinIO web interface. This foundational knowledge will help you manage and scale MinIO deployments in a Kubernetes environment.
