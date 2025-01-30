# Global Variables
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group for this resource."
}

variable "location" {
  type        = string
  description = "The location of the resource."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "description" {
  type        = string
  description = "A description for the resources (less than or equal to 512 characters)."
  default     = "A resource deployed by Terraform."

  validation {
    condition = (
      length(var.description) < 512
    )
    error_message = "The description must be less than or equal to 512 characters."
  }
}

# azurerm_storage_account variables
variable "name" {
  description = "Specifies the name of the storage account. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
  type        = string
}

variable "account_kind" {
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. Defaults to StorageV2."
  type        = string
  default     = "StorageV2"

  validation {
    condition = (
      contains(["BlockBlobStorage", "FileStorage", "StorageV2"], var.account_kind)
    )
    error_message = "The value for account_kind must be one of BlobStorage, BlockBlobStorage, FileStorage, Storage, or StorageV2."
  }
}

variable "access_tier" {
  type        = string
  description = "Defines the access tier StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot."
  default     = "Hot"

  validation {
    condition = (
      contains(["Hot", "Cool"], var.access_tier)
    )
    error_message = "The value for storage_account_access_tier must be one of Hot or Cool."
  }
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
  default     = "Standard"

  validation {
    condition = (
      contains(["Standard", "Premium"], var.account_tier)
    )
    error_message = "The value for account_tier must be one of Standard or Premium."
  }
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa."
  default     = "LRS"

  validation {
    condition = (
      contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    )
    error_message = "The value for storage_account_replication_type must be one of LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
  }
}

variable "active_directory" {
  type = object({
    storage_sid         = string
    domain_name         = string
    domain_sid          = string
    domain_guid         = string
    forest_name         = string
    netbios_domain_name = string
  })
  default = null
}

variable "allow_nested_items_to_be_public" {
  type        = bool
  description = "Allow or disallow nested items within this Account to opt into being public. Defaults to true. At this time (January 2023) allow_nested_items_to_be_public is only supported in the Public Cloud, China Cloud, and US Government Cloud."
  default     = true
}

variable "azure_files_authentication_directory_type" {
  type        = string
  description = "Specifies the directory service used. Possible values are AADDS and AD."
  default     = null
}

variable "blob_delete_retention_days" {
  type        = number
  description = "Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7."
  validation {
    condition     = var.blob_delete_retention_days >= 1 && var.blob_delete_retention_days <= 365
    error_message = "The value for blob_delete_retnetion_days must be between 1 and 365 days."
  }
  default = 7
}

variable "container_delete_retention_days" {
  type        = number
  description = "Specifies the number of days that the container should be retained, between 1 and 365 days. Defaults to 7."
  validation {
    condition     = var.container_delete_retention_days >= 1 && var.container_delete_retention_days <= 365
    error_message = "The value for container_delete_retnetion_days must be between 1 and 365 days."
  }
  default = 7
}

variable "cross_tenant_replication_enabled" {
  type        = bool
  description = "Should cross Tenant replication be enabled? Defaults to true."
  default     = true
}

variable "custom_domain" {
  description = "An object for custom domain containing the Custom Domain Name to use for the Storage Account, which will be validated by Azure and a bool if Should the Custom Domain Name be validated by using indirect CNAME validation?"
  type = object({
    name          = string         # The Custom Domain Name to use for the Storage Account, which will be validated by Azure.
    use_subdomain = optional(bool) # Should the Custom Domain Name be validated by using indirect CNAME validation?
  })
  default = {
    name          = null
    use_subdomain = false
  }
}

variable "default_to_oauth_authentication" {
  type        = bool
  description = "Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false."
  default     = false
}

variable "edge_zone" {
  type        = string
  description = "Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created."
  default     = null
}

variable "https_traffic_only_enabled" {
  type        = bool
  description = "Boolean flag which forces HTTPS if enabled. Defaults to true." # Microsoft Docs: https://docs.microsoft.com/azure/storage/storage-require-secure-transfer/
  default     = true
}

variable "immutability_policy" {
  type = object({
    allow_protected_append_writes = bool   # When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted.
    state                         = string # Defines the mode of the policy. Disabled state disables the policy, Unlocked state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property, Locked state only allows the increase of the immutability retention time. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states. Only a policy in an Unlocked state can transition to a Locked state which cannot be reverted.
    period_since_creation_in_days = number # The immutability period for the blobs in the container since the policy creation, in days.
  })
  default = null
}

variable "infrastructure_encryption_enabled" {
  type        = bool
  description = "Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false."
  default     = false
}

variable "is_hns_enabled" {
  type        = bool
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2. Changing this forces a new resource to be created. Defaults to false. This can only be true when account_tier is Standard or when account_tier is Premium and account_kind is BlockBlobStorage." # Microsoft Docs: https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-quickstart-create-account/
  default     = false
}

variable "large_file_share_enabled" {
  type        = bool
  description = "Is Large File Share Enabled?"
  default     = false
}

variable "min_tls_version" {
  type        = string
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts."
  default     = "TLS1_2"
}

variable "nfsv3_enabled" {
  type        = bool
  description = "s NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to false. This can only be true when account_tier is Standard and account_kind is StorageV2, or account_tier is Premium and account_kind is BlockBlobStorage. Additionally, the is_hns_enabled is true, and enable_https_traffic_only is false."
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether or not public network access is allowed for this Storage account. Defaults to true"
  default     = true
}

variable "queue_cors_rule" {
  type = object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  })
  default = null
}

variable "queue_encryption_key_type" {
  type        = string
  description = "The encryption type of the queue service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service."
  default     = "Service"

  validation {
    condition = (
      contains(["Service", "Account"], var.queue_encryption_key_type)
    )
    error_message = "The value for queue_encryption_key_type must be Service or Account."
  }
}

variable "queue_logging" {
  type = object({
    delete                = bool             # Indicates whether all delete requests should be logged. Changing this forces a new resource.
    read                  = bool             # Indicates whether all read requests should be logged. Changing this forces a new resource.
    version               = string           # The version of storage analytics to configure. Changing this forces a new resource.
    write                 = bool             # Indicates whether all write requests should be logged. Changing this forces a new resource.
    retention_policy_days = optional(number) # Specifies the number of days that logs will be retained. Changing this forces a new resource.
  })
  default = null
}

variable "queue_metrics" {
  type = object({
    enabled                      = bool
    minute_version               = optional(string)
    minute_include_apis          = optional(bool)
    minute_retention_policy_days = optional(number)
    hour_version                 = optional(string)
    hour_include_apis            = optional(bool)
    hour_retention_policy_days   = optional(number)
  })
  default = {
    enabled = false
  }
}

variable "restore_policy_days" {
  type        = number
  description = "Specifies the number of days that the blob can be restored, between 1 and 365 days. This must be less than the days specified for blob_delete_retention_policy."
  default     = 7
  validation {
    condition     = var.restore_policy_days >= 1 && var.restore_policy_days <= 365
    error_message = "The value for restore_policy_days must be between 1 and 365 days and less than blob_delete_retention_days."
  }
}

variable "routing" {
  type = object({
    publish_internet_endpoints  = bool   # Should internet routing storage endpoints be published? Defaults to false.
    publish_microsoft_endpoints = bool   # Should Microsoft routing storage endpoints be published? Defaults to false.
    choice                      = string # Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.
  })
  default = {
    choice                      = "MicrosoftRouting"
    publish_internet_endpoints  = false
    publish_microsoft_endpoints = false
  }
}

variable "sas_policy_period" {
  type        = string
  description = "The SAS expiration period in format of DD.HH:MM:SS."
  default     = null
}

variable "sftp_enabled" {
  type        = bool
  description = "    Boolean, enable SFTP for the storage account. SFTP support requires is_hns_enabled set to true. Defaults to false." # Microsoft Documentation: https://learn.microsoft.com/azure/storage/blobs/secure-file-transfer-protocol-support
  default     = false
}

variable "shared_access_key_enabled" {
  type        = bool
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true."
  default     = true
}

variable "share_cors_rule" {
  type = object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  })
  default = null
}

variable "share_retention_days" {
  type        = number
  description = "Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 7."
  validation {
    condition     = var.share_retention_days >= 1 && var.share_retention_days <= 365
    error_message = "The value for share_retnetion_days must be between 1 and 365 days."
  }
  default = 7
}

variable "share_smb" {
  type = object({
    versions                        = optional(string) # A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1.
    authentication_types            = optional(string) # A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos.
    kerberos_ticket_encryption_type = optional(string) # A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256.
    channel_encryption_type         = optional(string) # A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM.
    multichannel_enabled            = optional(bool)   # Indicates whether multichannel is enabled. Defaults to false. This is only supported on Premium storage accounts.
  })
  default = {}
}
variable "static_website_config" {
  type = object({
    index_document     = optional(string)
    error_404_document = optional(string)
  })
  default = null
}

variable "storage_blob_properties" {
  type = object({
    versioning_enabled            = optional(bool)   # Is versioning enabled? Default to false.
    change_feed_enabled           = optional(bool)   # Is the blob service properties for change feed events enabled? Default to false.
    change_feed_retention_in_days = optional(number) # The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years). Setting this to null (or omit this in the configuration file) indicates an infinite retention of the change feed.
    default_service_version       = optional(string) # The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version. Defaults to 2020-06-12.
  })
  default = {
    change_feed_enabled           = false
    change_feed_retention_in_days = null
    default_service_version       = "2020-06-12"
    versioning_enabled            = false
  }
}

variable "storage_blob_cors_rule" {
  type = object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  })
  default = null
}

variable "table_encryption_key_type" {
  type        = string
  description = "The encryption type of the table service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service."
  default     = "Service"

  validation {
    condition = (
      contains(["Service", "Account"], var.table_encryption_key_type)
    )
    error_message = "The value for table_encryption_key_type must be Service or Account."
  }
}

# azurerm_storage_account_customer_managed_key variables

variable "customer_managed_key_vault_id" {
  type        = string
  description = "The ID of the Key Vault to host the customer managed key."
  default     = null
}

variable "customer_managed_key_name" {
  type        = string
  description = " The name of customer managed Key Vault Key."
  default     = null
}

variable "customer_managed_key_version" {
  type        = string
  description = "The version of customer managed Key Vault Key. Remove or omit this argument to enable Automatic Key Rotation."
  default     = null
}

variable "customer_managed_user_assigned_identity_id" {
  type        = string
  description = "The ID of a user assigned identity for the customer managed key."
  default     = null
}

# azurerm_storage_account_network_rules variables

variable "network_rules_default_action" {
  type        = string
  description = "Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow."
  default     = null
}

variable "network_rules_bypass" {
  type        = list(string)
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None."
  default     = []

  validation {
    condition     = !contains([for item in var.network_rules_bypass : contains(["Logging", "Metrics", "AzureServices", "None"], var.network_rules_bypass)], false)
    error_message = "The value for network_rules_bypass must be are any combination of Logging, Metrics, AzureServices, or None as a list."
  }
}

variable "network_rules_ip_rules" {
  type        = list(string)
  description = "List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed."
  default     = []
}

variable "network_rules_virtual_network_subnet_ids" {
  type        = list(string)
  description = "A list of virtual network subnet ids to to secure the storage account."
  default     = []
}

variable "network_rules_private_link_access" {
  type = object({
    endpoint_resource_id = string           # The resource id of the resource access rule to be granted access.
    endpoint_tenant_id   = optional(string) # The tenant id of the resource of the resource access rule to be granted access. Defaults to the current tenant id.
  })
  default = null
}

# azurerm_role_assignment variables

variable "role_assignment" {
  type = list(object({
    principal_id                           = string
    role_definition_id                     = optional(string)
    role_definition_name                   = optional(string)
    condition                              = optional(string)
    condition_version                      = optional(string)
    delegated_managed_identity_resource_id = optional(string)
    description                            = optional(string)
    skip_service_principal_aad_check       = optional(bool)
  }))
  default     = null
  description = "An object for RBAC scoped to the storage account. The object contains the principal_id, role_definition_id OR role_definition_name, condition, condition_version, delegated_managed_identity_resource_id, description, and skip_service_principal_aad_check."
}
