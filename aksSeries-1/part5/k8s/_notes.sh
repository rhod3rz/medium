# Part 1 & 2
cd k8s
kubectl apply -f .\0-namespace.yaml
kubectl apply -f .\1-nginx-80-pod.yaml
kubectl apply -f .\2-nginx-80-service.yaml
kubectl apply -f .\3-nginx-80-ingress.yaml
kubectl delete namespace titan

# Part 3
cd k8s
kubectl delete namespace titan
kubectl apply -f .\0-namespace.yaml
kubectl apply -f .\1-nginx-80-pod.yaml
kubectl apply -f .\2-nginx-80-service.yaml
kubectl apply -f .\4-akv2k8s.yaml
kubectl apply -f .\5-nginx-443-ingress.yaml
kubectl delete namespace titan

# Part 4
cd k8s
kubectl delete namespace titan
kubectl apply -f .\0-namespace.yaml
kubectl apply -f .\1-nginx-80-pod.yaml
kubectl apply -f .\2-nginx-80-service.yaml
kubectl apply -f .\6-cluster-issuer.yaml
kubectl apply -f .\7-nginx-443-ingress-cert-manager.yaml
kubectl delete namespace titan
kubectl delete clusterissuer letsencrypt-issuer

# Part 5
cd k8s
kubectl delete namespace titan
kubectl apply -f .\0-namespace.yaml
kubectl apply -f .\8-csi-driver.yaml
kubectl apply -f .\9-nginx-80-pod-secrets.yaml
kubectl delete namespace titan
kubectl delete clusterissuer letsencrypt-issuer

# POD TESTS
kubectl exec -it nginx -n titan -- /bin/sh
kubectl port-forward pod/nginx 8081:80 -n titan # Browse to http://localhost:8081

# SERVICE TESTS
kubectl port-forward service/nginx 8081:80 -n titan # Browse to http://localhost:8081

kubectl delete namespace titan
