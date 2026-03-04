output "resource_group_location" {
  description = "Lokalizacja resource group"
  value = azurerm_resource_group.project02.location
}

output "resource_group_name" {
  description = "Nazwa resource group"
  value = azurerm_resource_group.project02.name
}

output "resource_group_id" {
  description = "id resource grupy"
  value = azurerm_resource_group.project02.id
}

output "storage_account_primary_endpoint" {
  description = "Endpoint Storage Account"
  value = azurerm_storage_account.storage01.primary_blob_endpoint
}