output "resource_group_name" {
  description = "Nazwa stworzonej resource grupy"
  value = azurerm_resource_group.first_rg.name

}

output "resource_group_location" {
  description = "Lokalizacja resource grupy"
  value = azurerm_resource_group.first_rg.location
}

output "resource_group_id" {
  description = "ID resource grupy w Azure"
  value = azurerm_resource_group.first_rg.id
}