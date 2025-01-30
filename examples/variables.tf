# Global Variables
variable "rg_name" {
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

variable "subscription_id" {
  type        = string
  description = "The subscription ID for the Azure account."
}

variable "resource_group" {
  type        = string
  description = "The name of the resource group in which to create the storage account."
}