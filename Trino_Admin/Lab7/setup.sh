minikube start --cpus=4 --memory=8192 --network-plugin=cni --cni=false --extra-config=kubelet.housekeeping-interval=10s

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml 
sleep 20

minikube addons enable metrics-server

#run minio
chmod 777 ./minio/run_minio.sh
./minio/run_minio.sh

# run hive and postgres

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

chmod 777 hive/run-hive.sh
./hive/run-hive.sh


kubectl wait --for=condition=ready pod --all --namespace metastore 

#run trino

kubectl create namespace trino

kubectl create secret generic trino-auth-secret -n trino \
--from-file=password.db=./password.db 

kubectl annotate secret trino-auth-secret \
  meta.helm.sh/release-name=trino-cluster \
  meta.helm.sh/release-namespace=trino \
  --namespace trino

kubectl label secret trino-auth-secret \
  app.kubernetes.io/managed-by=Helm \
  --namespace trino

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout tls.key -out tls.crt -subj "/CN=trino-cluster-coordinator.trino.svc.cluster.local"

kubectl create secret tls certificates --cert=tls.crt --key=tls.key -n trino


openssl pkcs12 -export -out trino-keystore.p12 -inkey tls.key -in tls.crt -name "trino-client" -passout pass:"admin123"

keytool -import -alias trino-server -file tls.crt -keystore trino-truststore.jks -storepass admin123 -noprompt

mkdir ../tls-store

mv trino-keystore.p12 ../tls-store/
mv trino-truststore.jks ../tls-store/
mv tls.key  ../tls-store/
mv tls.crt ../tls-store/


kubectl create secret generic aws-credentials -n trino \
--from-literal=AWS_ACCESS_KEY_ID="minio" \
--from-literal=AWS_SECRET_ACCESS_KEY="minio123"


helm install -f values.yaml trino-cluster trino/trino --namespace trino --version 0.26.0

MINIKUBE_IP=$(minikube ip)
sudo bash -c "echo '$MINIKUBE_IP trino.local' >> /etc/hosts"


