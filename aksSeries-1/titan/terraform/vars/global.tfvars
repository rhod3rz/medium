#================================================================================================
# Environment Vars - global
#================================================================================================
tenant_id        = "73578441-dc3d-4ecd-a298-fc5c6f40e191" # UPDATE HERE.
terraform_sp     = "2aa9eba7-3055-4546-b8f2-ce10f98981d2" # UPDATE HERE.
location         = "northeurope"
application_code = "titan"
unique_id        = "230101"

#================================================================================================
# Key Vault Policies
#================================================================================================
keyvault_policies = [
  {
    access_policy_name = "rhodri.freer"                         # UPDATE HERE.
    object_id          = "72c94293-5323-480c-86e0-097289139d2f" # UPDATE HERE.
    key_permissions = [
      "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"
    ]
    secret_permissions = [
      "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
    ]
    certificate_permissions = [
      "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"
    ]
  },
  {
    access_policy_name = "sp-terraform-deployment"              # UPDATE HERE.
    object_id          = "89b77e65-0434-4628-87db-9f1dd6c262d4" # UPDATE HERE.
    key_permissions = [
      "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"
    ]
    secret_permissions = [
      "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
    ]
    certificate_permissions = [
      "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"
    ]
  }
]