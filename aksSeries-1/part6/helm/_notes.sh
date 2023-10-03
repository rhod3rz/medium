# RUN HELM CHART #

# 1. Update aks-tweaks_uai_agentpool_client_id = "de181897-1eb3-4a63-8bad-b3fa4e74a91c" in csi-driver.yaml.

# 2. Dry run.
cd helm
kubectl delete namespace titan
helm install --debug --dry-run titan ./titan

# 3. Install the chart.
helm install titan ./titan --namespace titan --create-namespace --wait
https://prd.rhod3rz.com/analytics
https://prd.rhod3rz.com

# 4. Interrogate.
helm list -A
helm status titan -n titan
helm get manifest titan -n titan > voting.yaml

# 5. Uninstall the chart.
helm uninstall titan -n titan
