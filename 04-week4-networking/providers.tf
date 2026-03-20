terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.1"
    }

  }
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "sttfstatemk2026"
    container_name       = "tfstate"
    key                  = "04-networking.tfstate"

  }
}

    provider "azurerm" {
    features {}
  }