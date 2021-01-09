variable "app_name" {}

variable "resource_group_name" {}

variable "location" {}

variable "account_tier" {}

variable "account_replication_type" {}

variable "keyvault" {
  type = object({
    name                            = string
    tenant_id                       = string
    object_id                       = string
    keys_permissions                = list(string)
    secrets_permissions             = list(string)
    sku_name                        = string
    enabled_for_deployment          = bool
    enabled_for_disk_encryption     = bool
    enabled_for_template_deployment = bool
    sku_name                        = string
  })
}