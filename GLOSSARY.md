# Terraform Glossary
## A
## B
## C
- **child module** - a module called from root module, contains resources for specific purpose (e.g. resource group, networking)
## D
## E
## F
## G
## H
- **HCL** - a language from Hashi Corp what terraform use.
## I
- **interpolation** - adding a variables to type string. We need to use ${variable}
## J
## K
## L 
- **locals** - create from variables. Save time, define in one file and can use from referring to other instructions. We can use short  name than refer 3 or more variables
## M
- **module** — reusable block of Terraform code, contains its own main.tf, variables.tf, outputs.tf
## N
## O
- **output** - It's a value that we define in code and it returns information after terraform apply, for example resource group name
## P
- **provider** - plugin, after defining it terraform know how to work, if we define azurerm he know - now we work with azure resources
## Q
## R
- **resource** - a one thing in cloud - can be Vnet, resource group, subnet, vm. In code, resource block tells Terraform to create and manage it.
- **root module** — the main directory where you run terraform apply
## S
## T
- **terraform state file** - terraform.tfstate - file where terraform read what you have, what you want to do and what resources exists > terraform know what should do add/modify or delete after terraform apply command
## U
## V
- **variable** - a values that we define in code. Define once and we can use it referring to others files. Hierarchy from weaker to the strongest - default in block variable {} > terraform.tfvars > TF_VAR_name > -var "name=value" in CLI
## W
## X
## Y
## Z