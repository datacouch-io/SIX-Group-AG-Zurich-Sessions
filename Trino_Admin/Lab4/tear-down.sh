helm uninstall trino-cluster -n trino
kubectl delete namespace trino
rm -r ../tls-store/