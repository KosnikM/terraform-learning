resource "azurerm_resource_group" "first_rg" {
  name     = "${local.name_prefix}-rg"
  location = var.location
  tags     = var.tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_virtual_network" "main_vnet" {
  name                = "${local.name_prefix}-vnet"
  location            = azurerm_resource_group.first_rg.location
  resource_group_name = azurerm_resource_group.first_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "app_subnet" {
  name                 = "subnet-app"
  resource_group_name  = azurerm_resource_group.first_rg.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_storage_account" "storage" {
  name                     = "stlearndev01"
  resource_group_name      = azurerm_resource_group.first_rg.name
  location                 = azurerm_resource_group.first_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.storage.id
}

data "azurerm_storage_account" "existing" {
  name = "stlearndev01"
  resource_group_name = azurerm_resource_group.first_rg.name
  
}

resource "azurerm_resource_group" "manual" {
  name = "rg-manual-test"
  location = "polandcentral"
}