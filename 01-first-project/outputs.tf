output "resource_group_name" {
  description = "Nazwa stworzonej resource grupy"
  value       = azurerm_resource_group.first_rg.name

}

output "resource_group_location" {
  description = "Lokalizacja resource grupy"
  value       = azurerm_resource_group.first_rg.location
}

output "resource_group_id" {
  description = "ID resource grupy w Azure"
  value       = azurerm_resource_group.first_rg.id
}

output "vnet_name" {
  description = "Nazwa Vnet"
  value       = azurerm_virtual_network.main_vnet.name

}

output "subnet_name" {
  description = "Nazwa subnetu"
  value       = azurerm_subnet.app_subnet.name

}

output "subnet_id" {
  description = "Subnet id"
  value       = azurerm_subnet.app_subnet.id

}

output "vnet_ID" {
  description = "Vnet id"
  value       = azurerm_virtual_network.main_vnet.id
}

output "storage_account_primary_endpoint" {
  description = "Endpoint Storage Account"
  value = data.azurerm_storage_account.existing.primary_blob_endpoint
}