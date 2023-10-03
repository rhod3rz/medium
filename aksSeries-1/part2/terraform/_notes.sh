terraform init -reconfigure -backend-config="key=env-prd.tfstate"
terraform fmt -recursive
terraform validate
terraform apply -var-file="vars/global.tfvars" -var-file="vars/env-prd.tfvars"
terraform destroy -var-file="vars/global.tfvars" -var-file="vars/env-prd.tfvars"
