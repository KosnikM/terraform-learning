output "vnet_name" {
  description = "Vnet_name"
  value       = azurerm_virtual_network.this.name
}
output "vnet_id" {
  description = "vnet.id"
  value       = azurerm_virtual_network.this.id
}
output "subnet_name" {
  description = "subnet_name"
  value       = azurerm_subnet.this.name
}
output "subnet_id" {
  description = "subnet_id"
  value       = azurerm_subnet.this.id
}
output "nsg_name" {
  description = "nsg_name"
  value       = azurerm_network_security_group.this.name
}
output "nsg_id" {
  description = "nsg_id"
  value       = azurerm_network_security_group.this.id
}

