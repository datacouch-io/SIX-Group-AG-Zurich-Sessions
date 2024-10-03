minikube start

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus -f prometheus-values.yaml
sleep 15
kubectl port-forward svc/prometheus-server 8090:80  &

kubectl apply -k "github.com/minio/operator?ref=v6.0.2"
sleep 5
kubectl apply -f tenant.yaml
sleep 20
kubectl port-forward svc/myminio-console 9090 -n minio-tenant &
