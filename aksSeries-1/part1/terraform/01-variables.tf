#================================================================================================
# Environment Vars - Global
#================================================================================================
variable "tenant_id" {}        # The azure tenant id.
variable "terraform_sp" {}     # The terraform service principal.
variable "location" {}         # Azure location to deploy resources in.
variable "application_code" {} # Project code used for naming.
variable "unique_id" {}        # A unique id for naming.

#================================================================================================
# Environment Vars
#================================================================================================
variable "environment" {}     # The environment name.
variable "subscription_id" {} # The subscription id.
