output "rg_name" {
  value = azurerm_resource_group.this.name
}

output "vnet_name" {
  value = module.networking.vnet_name
}
