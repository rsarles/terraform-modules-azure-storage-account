# Terraform Docs: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
# Microsoft Docs: https://learn.microsoft.com/en-us/azure/storage/
resource "azurerm_storage_account" "main" {
  # Required Attributes
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  #Required Attributes with Defaults
  account_tier             = var.account_kind == "BlockBlobStorage" || var.account_kind == "FileStorage" ? "Premium" : var.account_tier
  account_replication_type = var.account_replication_type

  # Optional Attributes with Defaults
  account_kind                      = var.account_kind
  access_tier                       = var.access_tier
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  default_to_oauth_authentication   = var.default_to_oauth_authentication
  https_traffic_only_enabled        = var.https_traffic_only_enabled
  infrastructure_encryption_enabled = var.account_kind == "StorageV2" || (var.account_kind == "BlockBlobStorage" && var.account_tier == "Premium") ? var.infrastructure_encryption_enabled : false
  is_hns_enabled                    = var.account_tier == "Standard" || var.account_kind == "BlockBlobStorage" ? var.is_hns_enabled : false
  min_tls_version                   = var.min_tls_version
  nfsv3_enabled                     = var.nfsv3_enabled # Review Complicated logic
  public_network_access_enabled     = var.public_network_access_enabled
  queue_encryption_key_type         = var.account_kind == "StorageV2" ? var.queue_encryption_key_type : "Service"
  sftp_enabled                      = var.is_hns_enabled == true ? var.sftp_enabled : false
  shared_access_key_enabled         = var.shared_access_key_enabled
  table_encryption_key_type         = var.account_kind == "StorageV2" ? var.table_encryption_key_type : "Service"

  # Optional Attributes
  edge_zone                = var.edge_zone
  large_file_share_enabled = var.large_file_share_enabled

  # Blocks
  dynamic "custom_domain" {
    for_each = var.custom_domain.name == null ? [] : ["enabled"]
    content {
      # Required Attributes
      name = var.custom_domain.name
      # Optional Attributes
      use_subdomain = var.custom_domain.use_subdomain
    }
  }

  dynamic "blob_properties" {
    for_each = (
    var.account_kind != "FileStorage" && var.storage_blob_cors_rule != null ? ["enabled"] : [])

    content {
      # Optional Attributes with Defaults
      versioning_enabled       = var.storage_blob_properties.versioning_enabled
      change_feed_enabled      = var.storage_blob_properties.change_feed_enabled
      default_service_version  = var.storage_blob_properties.default_service_version
      last_access_time_enabled = var.storage_blob_properties.last_access_time_enabled

      # Optional Attributes
      change_feed_retention_in_days = var.storage_blob_properties.change_feed_retention_in_days

      # Blocks
      dynamic "cors_rule" {
        for_each = var.storage_blob_cors_rule == null ? [] : ["enabled"]
        content {
          # Requred Attributes
          allowed_headers    = var.storage_blob_cors_rule.allowed_headers
          allowed_methods    = var.storage_blob_cors_rule.allowed_methods
          allowed_origins    = var.storage_blob_cors_rule.allowed_origins
          exposed_headers    = var.storage_blob_cors_rule.exposed_headers
          max_age_in_seconds = var.storage_blob_cors_rule.max_age_in_seconds
        }
      }

      delete_retention_policy {
        days = var.blob_delete_retention_days
      }

      dynamic "restore_policy" {
        for_each = var.storage_blob_properties.versioning_enabled == true && var.blob_delete_retention_days != null ? ["enabled"] : []
        content {
          days = var.restore_policy_days
        }
      }

      container_delete_retention_policy {
        days = var.container_delete_retention_days
      }
    }
  }

  dynamic "queue_properties" {
    for_each = var.queue_cors_rule == null || var.queue_logging == null ? [] : ["enabled"]
    content {
      dynamic "cors_rule" {
        for_each = var.queue_cors_rule == null ? [] : ["enabled"]
        content {
          # Requred Attributes
          allowed_headers    = var.queue_cors_rule.allowed_headers
          allowed_methods    = var.queue_cors_rule.allowed_methods
          allowed_origins    = var.queue_cors_rule.allowed_origins
          exposed_headers    = var.queue_cors_rule.exposed_headers
          max_age_in_seconds = var.queue_cors_rule.max_age_in_seconds
        }
      }

      dynamic "logging" {
        for_each = var.queue_logging == null ? [] : ["enabled"]
        content {
          delete                = var.queue_logging.delete
          read                  = var.queue_logging.read
          version               = var.queue_logging.version
          write                 = var.queue_logging.write
          retention_policy_days = var.queue_logging.retention_policy_days
        }
      }

      dynamic "minute_metrics" {
        for_each = var.queue_metrics.enabled == false ? [] : ["enabled"]
        content {
          enabled               = true
          version               = var.queue_metrics.minute_version
          include_apis          = var.queue_metrics.minute_include_apis
          retention_policy_days = var.queue_metrics.minute_retention_policy_days
        }
      }
      dynamic "hour_metrics" {
        for_each = var.queue_metrics.enabled == false ? [] : ["enabled"]
        content {
          enabled               = true
          version               = var.queue_metrics.hour_version
          include_apis          = var.queue_metrics.hour_include_apis
          retention_policy_days = var.queue_metrics.hour_retention_policy_days
        }
      }
    }
  }

  dynamic "share_properties" {
    for_each = var.share_cors_rule == null || var.share_smb == null ? [] : ["enabled"]
    content {
      dynamic "cors_rule" {
        for_each = var.share_cors_rule == {} ? [] : ["enabled"]
        content {
          # Requred Attributes
          allowed_headers    = var.share_cors_rule.allowed_headers
          allowed_methods    = var.share_cors_rule.allowed_methods
          allowed_origins    = var.share_cors_rule.allowed_origins
          exposed_headers    = var.share_cors_rule.exposed_headers
          max_age_in_seconds = var.share_cors_rule.max_age_in_seconds
        }
      }

      retention_policy {
        days = var.share_retention_days
      }

      dynamic "smb" {
        for_each = var.share_smb == null ? [] : ["enabled"]
        content {
          versions                        = var.share_smb.versions
          authentication_types            = var.share_smb.authentication_types
          kerberos_ticket_encryption_type = var.share_smb.kerberos_ticket_encryption_type
          channel_encryption_type         = var.share_smb.channel_encryption_type
          multichannel_enabled            = var.share_smb.multichannel_enabled
        }
      }
    }
  }

  dynamic "azure_files_authentication" {
    for_each = var.azure_files_authentication_directory_type == null ? [] : ["enabled"]
    content {
      directory_type = var.azure_files_authentication_directory_type

      dynamic "active_directory" {
        for_each = var.azure_files_authentication_directory_type == "AD" ? ["enabled"] : []
        content {
          storage_sid         = var.active_directory.storage_sid
          domain_name         = var.active_directory.domain_name
          domain_sid          = var.active_directory.domain_sid
          domain_guid         = var.active_directory.domain_guid
          forest_name         = var.active_directory.forest_name
          netbios_domain_name = var.active_directory.netbios_domain_name
        }
      }
    }
  }

  routing {
    publish_internet_endpoints  = var.routing.publish_internet_endpoints
    publish_microsoft_endpoints = var.routing.publish_microsoft_endpoints
    choice                      = var.routing.choice
  }

  dynamic "immutability_policy" {
    for_each = var.immutability_policy == null ? [] : ["enabled"]
    content {
      allow_protected_append_writes = var.immutability_policy.allow_protected_append_writes
      state                         = var.immutability_policy.state
      period_since_creation_in_days = var.immutability_policy.period_since_creation_in_days
    }
  }

  dynamic "sas_policy" {
    for_each = var.sas_policy_period == null ? [] : ["enabled"]
    content {
      expiration_period = var.sas_policy.expiration_period
      expiration_action = "Log"
    }
  }

  tags = merge(
    var.tags,
    {
      Description = var.description
    }
  )
}

resource "azurerm_storage_account_static_website" "main" {
  count = var.static_website_config == null ? 0 : 1

  storage_account_id = azurerm_storage_account.main.id
  error_404_document = var.static_website_config.error_404_document
  index_document     = var.static_website_config.index_document
}

# Terraform Docs: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_customer_managed_key
# Microsoft Docs: https://learn.microsoft.com/en-us/azure/storage/common/customer-managed-keys-overview?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json
resource "azurerm_storage_account_customer_managed_key" "main" {
  count = var.customer_managed_key_vault_id == null ? 0 : 1

  storage_account_id        = azurerm_storage_account.main.id
  key_vault_id              = var.customer_managed_key_vault_id
  key_name                  = var.customer_managed_key_name
  key_version               = var.customer_managed_key_version
  user_assigned_identity_id = var.customer_managed_user_assigned_identity_id
}

# Terraform Docs: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules
resource "azurerm_storage_account_network_rules" "main" {
  count = var.network_rules_default_action == null ? 0 : 1

  storage_account_id = azurerm_storage_account.main.id

  default_action             = var.network_rules_default_action
  bypass                     = var.network_rules_bypass
  ip_rules                   = var.network_rules_ip_rules
  virtual_network_subnet_ids = var.network_rules_virtual_network_subnet_ids

  dynamic "private_link_access" {
    for_each = var.network_rules_private_link_access == null ? [] : ["enabled"]

    content {
      endpoint_resource_id = var.network_rules_private_link_access.endpoint_resource_id
      endpoint_tenant_id   = var.network_rules_private_link_access.endpoint_tenant_id
    }
  }
}