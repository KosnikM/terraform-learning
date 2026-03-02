resource "azurerm_resource_group" "first_rg" {
  name = var.resource_group_name
  location = var.location

  tags = { 
    Environment = "Learning"
    Owner = "Mateusz"
    Project = "Terraform-Day1"
    ManagedBy = "Terraform"

   }
  
}