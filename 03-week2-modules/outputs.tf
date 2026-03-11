# Outputs
output "name" {
  description = "resource group name"
  value       = module.rg.name
}

output "group_id" {
  description = "resource group id"
  value       = module.rg.id
}

output "staging_name" {
  description = "resource group name"
  value       = module.rg_staging.name
}

output "staging_id" {
  description = "resource group id"
  value       = module.rg_staging.id
}

output "vnet_name" {
    value       = module.networking.vnet_name
}
output "vnet_id" {
    value       = module.networking.vnet_id
}
output "subnet_name" {
    value       = module.networking.subnet_name
}
output "subnet_id" {
    value       = module.networking.subnet_id
}
output "nsg_name" {
    value       = module.networking.nsg_name
}
output "nsg_id" {
    value       = module.networking.nsg_id
}



 