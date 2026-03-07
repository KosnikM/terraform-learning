# Outputs
output "name" {
 description = "resource group name"
 value = module.rg.name
}

output "group_id" {
  description = "resource group id"
  value = module.rg.id
}