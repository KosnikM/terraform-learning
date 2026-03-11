# Providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg-terraform-state"
    storage_account_name = "sttfstatemk2026"
    container_name = "tfstate"
    key = "week2.tfstate"
    
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}