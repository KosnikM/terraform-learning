# Root module
module "rg" {
  source  = "./modules/resource-group"
  name = "rg-${var.project_name}-${var.environment}"
  tags = {
    environment = var.environment   
    project = var.project_name
  }
}

module "rg_staging" {
    source  = "./modules/resource-group"
    name = "rg-${var.project_name}-staging"
    tags = {
      environment = "staging"
      project = var.project_name
    }
 }
