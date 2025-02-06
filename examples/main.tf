module "resource_group" {
  source          = "git::https://github.com/rsarles/terraform-modules-azure-resource-group.git"
  name            = var.rg_name
  location        = var.location
  subscription_id = var.subscription_id
  tags            = var.tags
}

module "storage_account" {
  source = "git::https://github.com/rsarles/terraform-modules-azure-storage-account.git"

  name                     = var.name
  location                 = var.location
  resource_group_name      = module.resource_group.name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
  tags                     = var.tags
}