minikube start 

minikube addons enable ingress
minikube addons enable ingress-dns

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

sleep 30


helm install -f values.yaml trino-cluster trino/trino --namespace trino --version 0.26.0

MINIKUBE_IP=$(minikube ip)
sudo bash -c "echo '$MINIKUBE_IP trino.local' >> /etc/hosts"


