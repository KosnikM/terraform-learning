# Outputs
output "name" {
  description = "resource group name"
  value = azurerm_resource_group.this.name
}

output "id" {
  description = "resource group ID"
  value = azurerm_resource_group.this.id
}