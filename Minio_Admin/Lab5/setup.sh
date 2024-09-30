#!/bin/bash

kubectl apply -f ldap.yaml

sleep 15

# Get the OpenLDAP pod name dynamically (replace <namespace> with your namespace)
POD_NAME=$(kubectl get pods  -l app=openldap -o jsonpath="{.items[0].metadata.name}")

# Copy the ou.ldif file to the OpenLDAP pod
kubectl cp ou.ldif $POD_NAME:/tmp/ou.ldif 

# Copy the new_user.ldif file to the OpenLDAP pod
kubectl cp new_user.ldif $POD_NAME:/tmp/new_user.ldif 

# Execute a command in the OpenLDAP pod (enter bash in this case)
kubectl exec -it $POD_NAME -- ldapadd -x -D "cn=admin,dc=min,dc=io" -w admin -f /tmp/ou.ldif
kubectl exec -it $POD_NAME -- ldapadd -x -D "cn=admin,dc=min,dc=io" -w admin -f /tmp/new_user.ldif


kubectl apply -f tenant.yaml

sleep 15

kubectl port-forward svc/myminio-hl 9000 -n minio-tenant &
mc alias set myminio1 http://localhost:9000 minio minio123
mc idp ldap policy attach myminio1 readwrite --user='uid=john,ou=sixgroups,dc=min,dc=io'

kubectl port-forward svc/myminio-console 9090 -n minio-tenant &




