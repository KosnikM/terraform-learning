# Terraform Glossary
## A
## B
- **backend** — where Terraform stores state file, can be local (disk) or remote (Azure Storage Account)
## C
- **count** — creates N identical copies of a resource, identified by index (0, 1, 2)
- **CIDR** — notation for IP address range, number after / means how many bits are fixed (e.g. /16 = first 2 octets fixed)
- **child module** - a module called from root module, contains resources for specific purpose (e.g. resource group, networking)
## D
- **dynamic block** — repeats a block inside a resource (e.g. security_rule in NSG), uses for_each on a list
## E
## F
- **for_each** — creates resources from a map or set, identified by key (e.g. "web", "app"), safer than count
## G
## H
- **HCL** - a language from Hashi Corp what terraform use.
## I
- **interpolation** - adding a variables to type string. We need to use ${variable}
## J
## K
## L 
- **locals** - create from variables. Save time, define in one file and can use from referring to other instructions. We can use short  name than refer 3 or more variables
- **locking (state locking)** — mechanism that prevents two people from modifying state at the same time
## M
- **multi-env** — strategy of managing multiple environments (dev/staging/prod) with separate folders, each with own backend and state file
- **module** — reusable block of Terraform code, contains its own main.tf, variables.tf, outputs.tf
## N
- **NSG (Network Security Group)** — firewall rules attached to subnet or NIC, controls inbound/outbound traffic
- **NIC (Network Interface Card)** — connection point between VM and virtual network

## O
- **output** - It's a value that we define in code and it returns information after terraform apply, for example resource group name
## P
- **provider** - plugin, after defining it terraform know how to work, if we define azurerm he know - now we work with azure resources
## Q
## R
- **remote state** — state file stored in cloud (e.g. Azure Storage Account) instead of local disk, shared by whole team
- **resource** - a one thing in cloud - can be Vnet, resource group, subnet, vm. In code, resource block tells Terraform to create and manage it.
- **root module** — the main directory where you run terraform apply
## S
- **Storage Account** — Azure resource for storing data (files, blobs). Used as backend for Terraform remote state
- **subnet** — smaller network inside VNet, has its own address range (e.g. 10.0.1.0/24)
## T
- **Terragrunt** — wrapper tool for Terraform that automates multi-env folder approach, reduces code duplication
- **terraform state file** - terraform.tfstate - file where terraform read what you have, what you want to do and what resources exists > terraform know what should do add/modify or delete after terraform apply command
## U
## V
- **variable** - a values that we define in code. Define once and we can use it referring to others files. Hierarchy from weaker to the strongest - default in block variable {} > terraform.tfvars > TF_VAR_name > -var "name=value" in CLI
- **VNet (Virtual Network)** — isolated network in Azure, contains subnets, has address space (e.g. 10.0.0.0/16)
## W
- **workspace** — Terraform mechanism that creates separate state files for the same code, switch with terraform workspace select

## X
## Y
## Z