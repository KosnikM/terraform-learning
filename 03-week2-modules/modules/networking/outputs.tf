output "vnet_name" {
  description = "Vnet_name"
  value       = azurerm_virtual_network.this.name
}
output "vnet_id" {
  description = "vnet.id"
  value       = azurerm_virtual_network.this.id
}
output "subnet_names" {
  description = "map of subnet names"
  value       = { for key, subnet in azurerm_subnet.this : key => subnet.name }
}
output "subnet_ids" {
  description = "map of subnet IDs"
  value       = { for key, subnet in azurerm_subnet.this : key => subnet.id }
}
output "nsg_name" {
  description = "nsg_name"
  value       = azurerm_network_security_group.this.name
}
output "nsg_id" {
  description = "nsg_id"
  value       = azurerm_network_security_group.this.id
}
