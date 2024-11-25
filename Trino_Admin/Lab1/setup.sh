kubectl create namespace trino
helm install -f values.yaml trino-cluster trino/trino --namespace trino --version 0.26.0