# Lab 7: Exploring MinIO Operator CRDs and Custom Controllers

**Time:** 25 Minutes

## What is an Operator?
An Operator is a special type of custom controller designed to manage complex applications. Operators use CRDs to define the application and its components, and they use controller logic to manage the application lifecycle, including deployment, scaling, backup, recovery, and upgrades.

### How Do CRDs and Custom Controllers Work Together?
- **CRDs:** Define the schema and API for a custom resource.
- **Custom Controller:** Watches for changes to instances of the CRD and takes actions to ensure that the actual state of the cluster matches the desired state defined in the CRD.

For example, if you define a CRD for a database and create an instance of this resource, the custom controller (or Operator) will ensure that the database is created, configured, and maintained according to the specifications in the CRD.

---

## Step 1: Introduction to the MinIO Operator

Now that you have an understanding of CRDs and custom controllers, let's explore how the MinIO Operator leverages these concepts to manage MinIO deployments on Kubernetes.

### What is the MinIO Operator?
The MinIO Operator is a Kubernetes Operator designed to simplify the deployment, management, and scaling of MinIO instances. It uses CRDs to define MinIO-specific resources, such as tenants, buckets, and consoles, and a custom controller to manage these resources.

### Key Components:
- **CRDs:** Define custom resources like Tenant, Bucket, Console, and Certificate.
- **Custom Controller:** Automates the creation, management, and scaling of MinIO instances based on the custom resources.

---

## Step 2: Run MinIO Operator Using `kubectl`

1. **Run the MinIO Operator:**

    ```bash
    kubectl apply -k "github.com/minio/operator?ref=v6.0.2"
    ```

2. **Verify Operator Pods are Created in the `minio-operator` Namespace:**

    ```bash
    kubectl get pod -n minio-operator
    ```

3. **Check What CRDs are Included by MinIO Operator:**

    ```bash
    kubectl get crd -n minio-operator
    ```

---

## Step 3: Create a MinIO Tenant Resource Using the Tenant CRD

Before creating the Tenant resource, we need to create a namespace and secrets that are required in the Tenant YAML.

1. **Create a Namespace for the MinIO Tenant:**

    ```yaml
    apiVersion: v1
    kind: Namespace
    metadata:
      name: minio-tenant
    ```

2. **Create Two Secrets to Be Used in the Tenant CRD:**

    ```yaml
    apiVersion: v1
    kind: Secret
    metadata:
      name: storage-configuration
      namespace: minio-tenant
    stringData:
      config.env: |-
        export MINIO_ROOT_USER="minio"
        export MINIO_ROOT_PASSWORD="minio123"
        export MINIO_STORAGE_CLASS_STANDARD="EC:2"
        export MINIO_BROWSER="on"
    type: Opaque
    ```

    ```yaml
    apiVersion: v1
    kind: Secret
    metadata:
      name: storage-user
      namespace: minio-tenant
    data:
      CONSOLE_ACCESS_KEY: Y29uc29sZQ==  # Base64 encoded value for 'console'
      CONSOLE_SECRET_KEY: Y29uc29sZTEyMw==  # Base64 encoded value for 'console123'
    type: Opaque
    ```

3. **Create MinIO Tenant Using Tenant CRD Spec:**

    When a Tenant resource is created, the MinIO Operator custom controller watches this resource and automatically creates the necessary Kubernetes resources (StatefulSets, Pods, PVCs, and Services) to deploy the MinIO instances.

    ```yaml
    apiVersion: minio.min.io/v2
    kind: Tenant
    metadata:
      labels:
        app: minio
      name: myminio
      namespace: minio-tenant
    spec:
      configuration:
        name: storage-configuration
      image: quay.io/minio/minio:RELEASE.2024-08-17T01-24-54Z
      mountPath: /export
      pools:
      - name: pool-0
        servers: 2
        volumeClaimTemplate:
          apiVersion: v1
          kind: persistentvolumeclaims
          spec:
            accessModes:
            - ReadWriteOnce
            resources:
              requests:
                storage: 1Gi
            storageClassName: standard
        volumesPerServer: 2
      requestAutoCert: true
      users:
      - name: storage-user
    ```

### Tenant CRD Creates the Following Built-in Resources:
- **Pods:** One Pod per MinIO server instance, each running a MinIO container.
- **StatefulSets:** A StatefulSet is created to manage the Pods, ensuring they have persistent storage and stable network identities.
- **PersistentVolumeClaims (PVCs):** PVCs are created for each storage volume defined in the pools section to provide persistent storage to the MinIO Pods.
- **Services:**
  - **Headless Service:** Manages the StatefulSet and provides stable network identities for the MinIO instances.
  - **LoadBalancer/ClusterIP Service:** Exposes the MinIO service to external users.
  - **Console Service:** Exposes the MinIO management console.

4. **Verify the Creation of the Tenant:**

    ```bash
    kubectl get tenant -n minio-tenant
    ```

5. **Check All Built-in Objects Created by the Tenant:**

    ```bash
    kubectl get all -n minio-tenant
    ```

6. **Check the PersistentVolumeClaims (PVCs):**

    ```bash
    kubectl get pvc -n minio-tenant
    ```

---

**END OF LAB**
