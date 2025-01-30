module "resource_group" {
    source = "github.com/rsarles/terraform-modules-azure-resource-group"
    name            = var.rg_name
    location        = var.location
    subscription_id = var.subscription_id
    tags            = var.tags
}

module "storage_account" {
    source = "github.com/rsarles/terraform-modules-azure-storage-account" 
    
    name            = var.name
    location        = var.location
    resource_group  = var.resource_group
    account_tier    = var.account_tier
    account_replication_type = var.account_replication_type
    account_kind    = var.account_kind
    tags            = var.tags
}