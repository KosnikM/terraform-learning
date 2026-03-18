resource "azurerm_resource_group" "this" {
  name                = "rg-${var.project_name}-${var.environment}"
  location            = "polandcentral"

}

module "networking" {
  source              = "../../modules/networking"
  resource_group_name = azurerm_resource_group.this.name
  location            = "polandcentral"
  vnet_name           = "vnet-${var.project_name}-${var.environment}"
  subnets              = var.subnets
  nsg_name            = "nsg-${var.project_name}-${var.environment}"
  tags = {
    environment = var.environment
    project     = var.project_name
  }
}