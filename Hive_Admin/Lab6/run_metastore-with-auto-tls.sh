kubectl delete namespace metastore
kubectl create namespace metastore

kubectl create secret generic minio-credentials -n  metastore \
 --from-literal=AWS_ACCESS_KEY=minio \
--from-literal=AWS_SECRET_ACCESS_KEY=minio123

kubectl create secret generic postgres-secret -n metastore \
  --from-literal=adminPasswordKey="admin123" \
  --from-literal=userPasswordKey="user123" \
  --from-literal=replicationPasswordKey="replica123"

chmod 777 postgres/run-postgres.sh
./postgres/run-postgres.sh

kubectl wait --for=condition=ready pod --all --namespace metastore 

docker build -t metastore-new hive/docker

minikube image load metastore-new

chmod 777 hive/run-hive.sh
./hive/run-hive.sh

