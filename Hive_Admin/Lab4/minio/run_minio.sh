kubectl apply -k "github.com/minio/operator?ref=v6.0.2"
sleep 20
kubectl apply -f minio/tenant.yaml
# Use kubectl wait to ensure all pods are ready
kubectl wait --for=condition=ready pod --all --namespace=minio-tenant

# Check the status of the wait command
if [ $? -eq 0 ]; then
    echo "All pods are running and ready in the namespace 'minio-tenant'."
else
    echo "Timeout or error occurred while waiting for pods to be ready in the namespace 'minio-tenant'."
fi
kubectl apply -f minio/create_bucket.yaml