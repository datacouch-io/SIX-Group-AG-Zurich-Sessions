# Lab 6: Understanding Custom Resource Definitions (CRDs) in Kubernetes and MinIO Operator

**Time:** 15 Minutes

## Step 1: Introduction to Custom Resource Definitions (CRDs) in Kubernetes

### What are Custom Resource Definitions (CRDs)?
Custom Resource Definitions (CRDs) are a powerful feature in Kubernetes that allows users to define their own custom resources. These resources function like the built-in resources in Kubernetes (such as Pods, Services, etc.) but are defined and managed according to user specifications. CRDs enable the extension of Kubernetes APIs, allowing you to manage custom applications and workflows within a Kubernetes cluster.

### Why Use CRDs?
- **Extend Kubernetes API:** CRDs allow you to create new resource types that can be managed via the Kubernetes API.
- **Custom Workflows:** They enable the creation of custom workflows tailored to specific applications, such as managing databases, message queues, or any other service.
- **Automation:** Paired with custom controllers (often referred to as Operators), CRDs help automate complex operations, such as backup, restore, and scaling of applications.

---

## Step 2: Create and Apply a Custom Resource Definition (CRD)

1. **Locate the CRD YAML file in the Lab6 folder.**

    The following YAML defines a new custom resource called `MyResource` under the group `mydomain.com`.

    ```yaml
    apiVersion: apiextensions.k8s.io/v1
    kind: CustomResourceDefinition
    metadata:
      name: myresources.mydomain.com
    spec:
      group: mydomain.com
      versions:
        - name: v1
          served: true
          storage: true
          schema:
            openAPIV3Schema:
              type: object
              properties:
                spec:
                  type: object
                  properties:
                    field1:
                      type: string
      scope: Namespaced
      names:
        plural: myresources
        singular: myresource
        kind: MyResource
        shortNames:
        - mr
    ```

2. **Apply the CRD:**

    First, apply the CRD to your Kubernetes cluster to create the new custom resource definition:

    ```bash
    kubectl apply -f crd.yaml
    ```

3. **Check if the CRD has been successfully created:**

    ```bash
    kubectl get crd
    ```

    You should see `myresources.mydomain.com` listed among the CRDs.

---

## Step 3: Create and Apply a Custom Resource Instance

1. **Locate the `myresource.yaml` file in the Lab6 folder.**

    This YAML file defines an instance of your custom resource:

    ```yaml
    apiVersion: mydomain.com/v1
    kind: MyResource
    metadata:
      name: example-myresource
    spec:
      field1: "This is a test"
    ```

2. **Apply the custom resource instance:**

    Save this YAML to a file, e.g., `myresource.yaml`, and apply it:

    ```bash
    kubectl apply -f myresource.yaml
    ```

3. **Verify the Instance:**

    You can verify that the custom resource instance has been created by running:

    ```bash
    kubectl get myresources
    ```

---

**END OF LAB**
