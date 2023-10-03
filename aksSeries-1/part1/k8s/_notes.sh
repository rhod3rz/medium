cd k8s
k apply -f .\0-namespace.yaml
k apply -f .\1-nginx-80-pod.yaml
k apply -f .\2-nginx-80-service.yaml
k apply -f .\3-nginx-80-ingress.yaml # Browse to http://[public_ip]

# POD TESTS
kubectl exec -it nginx -n titan -- /bin/sh
k port-forward pod/nginx 8081:80 -n titan # Browse to http://localhost:8081

# SERVICE TESTS
k port-forward service/nginx 8081:80 -n titan # Browse to http://localhost:8081

k delete namespace titan
