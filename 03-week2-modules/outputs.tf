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
output "subnet_names" {
    value       = module.networking.subnet_names
}
output "subnet_ids" {
    value       = module.networking.subnet_ids
}
output "nsg_name" {
    value       = module.networking.nsg_name
}
output "nsg_id" {
    value       = module.networking.nsg_id
}



 