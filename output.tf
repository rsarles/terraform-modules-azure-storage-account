# Storage Account Outputs
output "id" {
  value       = azurerm_storage_account.main.id
  description = "The ID of the Storage Account."
  sensitive   = false
}

output "identity" {
  value       = azurerm_storage_account.main.identity
  description = "Details about the identity including th principal_id and tenant_id."
  sensitive   = true
}

output "name" {
  value       = azurerm_storage_account.main.name
  description = "The name of the Storage Account."
  sensitive   = false
}

output "primary_access_key" {
  value       = azurerm_storage_account.main.primary_access_key
  description = "The primary access key for the storage account."
  sensitive   = false
}

output "primary_blob_connection_string" {
  value       = azurerm_storage_account.main.primary_blob_connection_string
  description = "The connection string associated with the primary blob location."
  sensitive   = false
}

output "primary_blob_endpoint" {
  value       = azurerm_storage_account.main.primary_blob_endpoint
  description = "The endpoint URL for blob storage in the primary location."
  sensitive   = false
}

output "primary_blob_host" {
  value       = azurerm_storage_account.main.primary_blob_host
  description = "The hostname with port if applicable for blob storage in the primary location."
  sensitive   = false
}

output "primary_connection_string" {
  value       = azurerm_storage_account.main.primary_connection_string
  description = "The connection string associated with the primary location."
  sensitive   = false
}

output "primary_dfs_endpoint" {
  value       = azurerm_storage_account.main.primary_dfs_endpoint
  description = "The endpoint URL for DFS storage in the primary location."
  sensitive   = false
}

output "primary_dfs_host" {
  value       = azurerm_storage_account.main.primary_dfs_host
  description = "The hostname with port if applicable for DFS storage in the primary location."
  sensitive   = false
}

output "primary_file_endpoint" {
  value       = azurerm_storage_account.main.primary_file_endpoint
  description = "The endpoint URL for file storage in the primary location."
  sensitive   = false
}

output "primary_file_host" {
  value       = azurerm_storage_account.main.primary_file_host
  description = "The hostname with port if applicable for file storage in the primary location."
  sensitive   = false
}

output "primary_location" {
  value       = azurerm_storage_account.main.primary_location
  description = "The primary location of the storage account."
  sensitive   = false
}

output "primary_queue_endpoint" {
  value       = azurerm_storage_account.main.primary_queue_endpoint
  description = "The endpoint URL for queue storage in the primary location."
  sensitive   = false
}

output "primary_queue_host" {
  value       = azurerm_storage_account.main.primary_queue_host
  description = "The hostname with port if applicable for queue storage in the primary location."
  sensitive   = false
}

output "primary_table_endpoint" {
  value       = azurerm_storage_account.main.primary_table_endpoint
  description = "The endpoint URL for table storage in the primary location."
  sensitive   = false
}

output "primary_table_host" {
  value       = azurerm_storage_account.main.primary_table_host
  description = "The hostname with port if applicable for table storage in the primary location."
  sensitive   = false
}

output "primary_web_endpoint" {
  value       = azurerm_storage_account.main.primary_web_endpoint
  description = "The endpoint URL for web storage in the primary location."
  sensitive   = false
}

output "primary_web_host" {
  value       = azurerm_storage_account.main.primary_web_host
  description = "The hostname with port if applicable for web storage in the primary location."
  sensitive   = false
}

output "secondary_access_key" {
  value       = azurerm_storage_account.main.secondary_access_key
  description = "The secondary access key for the storage account."
  sensitive   = false
}

output "secondary_blob_connection_string" {
  value       = azurerm_storage_account.main
  description = "The connection string associated with the secondary blob location."
  sensitive   = false
}

output "secondary_blob_endpoint" {
  value       = azurerm_storage_account.main.secondary_blob_endpoint
  description = "The endpoint URL for blob storage in the secondary location."
  sensitive   = false
}

output "secondary_blob_host" {
  value       = azurerm_storage_account.main.secondary_blob_host
  description = "The hostname with port if applicable for blob storage in the secondary location."
  sensitive   = false
}

output "secondary_connection_string" {
  value       = azurerm_storage_account.main.secondary_connection_string
  description = "The connection string associated with the secondary location."
  sensitive   = false
}

output "secondary_dfs_endpoint" {
  value       = azurerm_storage_account.main.secondary_dfs_endpoint
  description = "The endpoint URL for DFS storage in the secondary location."
  sensitive   = false
}

output "secondary_dfs_host" {
  value       = azurerm_storage_account.main.secondary_dfs_host
  description = "The hostname with port if applicable for DFS storage in the secondary location."
  sensitive   = false
}

output "secondary_file_endpoint" {
  value       = azurerm_storage_account.main.secondary_file_endpoint
  description = "The endpoint URL for file storage in the secondary location."
  sensitive   = false
}

output "secondary_file_host" {
  value       = azurerm_storage_account.main.secondary_file_host
  description = "The hostname with port if applicable for file storage in the secondary location."
  sensitive   = false
}

output "secondary_location" {
  value       = azurerm_storage_account.main.secondary_location
  description = "The secondary location of the storage account."
  sensitive   = false
}

output "secondary_queue_host" {
  value       = azurerm_storage_account.main.secondary_queue_host
  description = "The hostname with port if applicable for queue storage in the secondary location."
  sensitive   = false
}
output "secondary_queue_endpoint" {
  value       = azurerm_storage_account.main.secondary_queue_endpoint
  description = "The endpoint URL for queue storage in the secondary location."
  sensitive   = false
}

output "secondary_table_endpoint" {
  value       = azurerm_storage_account.main.secondary_table_endpoint
  description = "The endpoint URL for table storage in the secondary location."
  sensitive   = false
}

output "secondary_table_host" {
  value       = azurerm_storage_account.main.secondary_table_host
  description = "The hostname with port if applicable for table storage in the secondary location."
  sensitive   = false
}

output "secondary_web_endpoint" {
  value       = azurerm_storage_account.main.secondary_web_endpoint
  description = "The endpoint URL for web storage in the secondary location."
  sensitive   = false
}

output "secondary_web_host" {
  value       = azurerm_storage_account.main.secondary_web_host
  description = "The hostname with port if applicable for web storage in the secondary location."
  sensitive   = false
}