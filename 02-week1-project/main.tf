resource "azurerm_resource_group" "project02" {
  name     = local.name_prefix
  location = var.location
  tags = var.tags
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "${local.name_prefix}-vnet"
  location            = azurerm_resource_group.project02.location
  resource_group_name = azurerm_resource_group.project02.name
  address_space       = ["10.0.0.0/16"]
  tags = var.tags
 
}

resource "azurerm_subnet" "subnet01" {
  name                 = "${local.name_prefix}-subnet"
  resource_group_name  = azurerm_resource_group.project02.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_storage_account" "storage01" {
  name                     = "week1project02"
  resource_group_name      = azurerm_resource_group.project02.name
  location                 = azurerm_resource_group.project02.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = var.tags
}

resource "azurerm_network_security_group" "nsg01" {
  name                = "${local.name_prefix}-nsg"
  location            = azurerm_resource_group.project02.location
  resource_group_name = azurerm_resource_group.project02.name
  tags = var.tags
}