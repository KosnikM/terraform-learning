# Root module
module "rg" {
  source = "./modules/resource-group"
  name   = "rg-${var.project_name}-${var.environment}"
  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

module "rg_staging" {
  source = "./modules/resource-group"
  name   = "rg-${var.project_name}-staging"
  tags = {
    environment = "staging"
    project     = var.project_name
  }
}

module "networking" {
  source              = "./modules/networking"
  resource_group_name = module.rg.name
  location            = "polandcentral"
  vnet_name           = "vnet-${var.project_name}-${var.environment}"
  subnets              = var.subnets
  nsg_name            = "nsg-${var.project_name}-${var.environment}"
  nsg_rules           = var.nsg_rules 
  tags = {
    environment = var.environment
    project     = var.project_name
  }
}


