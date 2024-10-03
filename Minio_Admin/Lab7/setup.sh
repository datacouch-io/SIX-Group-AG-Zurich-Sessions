#!/bin/bash

# Function to find the next available port
find_available_port() {
    local port=$1
    while lsof -i -P -n | grep ":$port" >/dev/null; do
        port=$((port+1))
    done
    echo $port
}

# Apply the MinIO operator
kubectl apply -k "github.com/minio/operator?ref=v6.0.2"
sleep 5

# Deploy MinIO Tenant for Site A
kubectl apply -f tenant-site-a.yaml
sleep 15

echo "Waiting for MinIO Pods to be ready in site-a..."
kubectl wait --for=condition=ready pods -l app=minio -n site-a --timeout=300s

# Find available ports for Site A
port_hl_a=$(find_available_port 9001)
port_console_a=$(find_available_port 9090)

# Port forward for Site A
kubectl port-forward svc/myminio-hl $port_hl_a:9000 -n site-a &
kubectl port-forward svc/myminio-console $port_console_a:9090 -n site-a &

# Deploy MinIO Tenant for Site B
kubectl apply -f tenant-site-b.yaml
sleep 15

echo "Waiting for MinIO Pods to be ready in site-b..."
kubectl wait --for=condition=ready pods -l app=minio -n site-b --timeout=300s

# Find available ports for Site B
port_hl_b=$(find_available_port 9002)
port_console_b=$(find_available_port 9091)

# Port forward for Site B
kubectl port-forward svc/myminio-hl $port_hl_b:9000 -n site-b &
kubectl port-forward svc/myminio-console $port_console_b:9090 -n site-b &

# MinIO Client (mc) configuration
mc alias set sitea http://localhost:$port_hl_a minio minio123
mc alias set siteb http://localhost:$port_hl_b minio minio123

# Create buckets in both sites
mc mb sitea/mybucket
mc version enable sitea/mybucket
mc mb siteb/mybucket
mc version enable siteb/mybucket

# Create replication policies
wget -O - https://min.io/docs/minio/linux/examples/ReplicationAdminPolicy.json | \
mc admin policy create sitea ReplicationAdminPolicy /dev/stdin
mc admin user add sitea ReplicationAdmin LongRandomSecretKey
mc admin policy attach sitea ReplicationAdminPolicy --user=ReplicationAdmin

wget -O - https://min.io/docs/minio/linux/examples/ReplicationRemoteUserPolicy.json | \
mc admin policy create siteb ReplicationRemoteUserPolicy /dev/stdin
mc admin user add siteb ReplicationRemoteUser LongRandomSecretKey
mc admin policy attach siteb ReplicationRemoteUserPolicy --user=ReplicationRemoteUser

# Set mc aliases for replication users
mc alias set replicadmin http://localhost:$port_hl_a ReplicationAdmin LongRandomSecretKey
mc alias set replicaremote http://localhost:$port_hl_b ReplicationRemoteUser LongRandomSecretKey

# Configure replication between Site A and Site B
mc replicate add replicadmin/mybucket --remote-bucket 'http://ReplicationRemoteUser:LongRandomSecretKey@myminio-hl.site-b.svc.cluster.local:9000/mybucket' --replicate "delete,delete-marker,existing-objects"
