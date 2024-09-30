# Start MiniKube with 4 cpu and 8GB memory
minikube start --cpus 4 --memory 8192 

# Apply MinIO Operator
kubectl apply -k "github.com/minio/operator?ref=v6.0.2"


# Apply tenant.yaml file for primary tenant
kubectl apply -f primary-tenant.yaml

# Check for tenant
kubectl get tenant -n primary

# Check for all resources
kubectl get all -n primary

# Apply tenant.yaml file for secondary tenany
kubectl apply -f secondary-tenant.yaml

# Check for tenant
kubectl get tenant -n secondary

# Check for all resources
kubectl get all -n secondary

# Open new terminal and Expose minio console service running on port 900
kubectl port-forward svc/primary-tenant-hl 9000:9000 -n primary

# Open new terminal and Expose minio console service running on port 9000
kubectl port-forward svc/secondary-tenant-hl 9001:9000 -n secondary


# Set an mc alias for primary
mc alias set primary-minio http://localhost:9000 minio  minio123


# Set an mc alias for Secondary
mc alias set secondary-minio http://localhost:9001 minio  minio123

#Create a bucket on Primary MinIO for tiering:
mc mb primary-minio/primary-bucket

#Create a bucket on Secondary MinIO:
mc mb secondary-minio/secondary-bucket

#Configure the Tier on Primary MinIO: You can configure the tier using the MinIO client command to link the secondary MinIO instance as a tier to the primary.
mc admin tier add s3 primary-minio secondary-tier \
  --access-key minio --secret-key minio123 \
  --endpoint http://secondary-tenant-hl.secondary.svc.cluster.local:9000 \
  --bucket secondary-bucket

#Check whether tier was attached?
mc ilm tier ls primary-minio/primary-bucket

#Create a lifecycle policy
mc ilm import primary-minio/primary-bucket < lifecycle.json

#Verify the lifecycle Policy
mc ilm export primary-minio/primary-bucket

#Test Object Tiering with Lifecycle Policy

mc cp testfile1.txt primary-minio/primary-bucket
mc ls primary-minio/primary-bucket

#Let's check secondary bucket
mc ls secondary-minio/secondary-bucket

