minikube start
./minio/run_minio.sh

kubectl create namespace metastore

kubectl create secret generic postgres-secret -n metastore \
  --from-literal=adminPasswordKey="admin123" \
  --from-literal=userPasswordKey="user123" \
  --from-literal=replicationPasswordKey="replica123"

helm install postgres oci://registry-1.docker.io/bitnamicharts/postgresql  -n metastore -f postgres/custom-values.yaml

kubectl wait --for=condition=ready pod --all --namespace metastore 

docker build -t metastore hive/docker/ --no-cache
minikube image load metastore
./hive/run-hive.sh

kubectl wait --for=condition=ready pod --all --namespace metastore

kubectl create namespace trino
helm install -f trino/values.yaml trino-cluster trino/trino --namespace trino --version 0.26.0

kubectl wait --for=condition=ready pod --all --namespace trino

kubectl port-forward svc/myminio-console 9090 -n minio-tenant &

kubectl get pod -n metastore
kubectl get pod -n trino
kubectl get pod -n minio-tenant
kubectl get svc -n trino





