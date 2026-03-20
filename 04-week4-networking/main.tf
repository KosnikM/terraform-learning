resource "azurerm_resource_group" "this" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  for_each = var.address_space
  name               = "vnet-${each.key}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = each.value.address_space
  
}

resource "azurerm_virtual_network_peering" "hub_to_spoke_dev" {
  name = "peering-${var.project_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this["hub"].name
  remote_virtual_network_id = azurerm_virtual_network.this["spoke-dev"].id
}
resource "azurerm_virtual_network_peering" "spoke_dev_to_hub" {
  name = "peering2-${var.project_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this["spoke-dev"].name
  remote_virtual_network_id = azurerm_virtual_network.this["hub"].id
}

resource "azurerm_virtual_network_peering" "hub_to_spoke_prod" {
  name = "peering3-${var.project_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this["hub"].name
  remote_virtual_network_id = azurerm_virtual_network.this["spoke-prod"].id
}

resource "azurerm_virtual_network_peering" "spoke_prod_to_hub" {
  name = "peering4-${var.project_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this["spoke-prod"].name
  remote_virtual_network_id = azurerm_virtual_network.this["hub"].id
}


locals {
  subnets = flatten([
    for vnet_key, vnet in var.address_space : [
      for subnet_key, subnet in vnet.subnets : {
        vnet_key       = vnet_key
        subnet_key     = subnet_key
        address_prefix = subnet.address_prefix
      }
    ]
  ])
}

resource "azurerm_subnet" "this" {
  for_each             = { for s in local.subnets : "${s.vnet_key}-${s.subnet_key}" => s }
  name                 = each.value.subnet_key
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this[each.value.vnet_key].name
  address_prefixes     = [each.value.address_prefix]
}

resource "azurerm_route_table" "spoke_rt" {
  name                = "rt-spoke-to-firewall"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_route" "to_firewall" {
  name                   = "route-to-firewall"
  resource_group_name    = azurerm_resource_group.this.name
  route_table_name       = azurerm_route_table.spoke_rt.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.1.4"
}

resource "azurerm_subnet_route_table_association" "spoke_dev" {
  subnet_id      = azurerm_subnet.this["spoke-dev-workload"].id
  route_table_id = azurerm_route_table.spoke_rt.id
}

resource "azurerm_subnet_route_table_association" "spoke_prod" {
  subnet_id      = azurerm_subnet.this["spoke-prod-workload"].id
  route_table_id = azurerm_route_table.spoke_rt.id
}

resource "azurerm_network_security_group" "spoke_dev" {
  name                = "nsg-spoke-dev-workload"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_network_security_group" "spoke_prod" {
  name                = "nsg-spoke-prod-workload"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet_network_security_group_association" "spoke_dev" {
  subnet_id                 = azurerm_subnet.this["spoke-dev-workload"].id
  network_security_group_id = azurerm_network_security_group.spoke_dev.id
}

resource "azurerm_subnet_network_security_group_association" "spoke_prod" {
  subnet_id                 = azurerm_subnet.this["spoke-prod-workload"].id
  network_security_group_id = azurerm_network_security_group.spoke_prod.id
}

resource "azurerm_network_security_rule" "allow_ssh" {
  resource_group_name         = azurerm_resource_group.this.name
  network_security_group_name = azurerm_network_security_group.spoke_dev.name
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.0.0.0/16"
    destination_address_prefix = "*"

}

resource "azurerm_network_security_rule" "deny_http" {
  resource_group_name         = azurerm_resource_group.this.name
  network_security_group_name = azurerm_network_security_group.spoke_dev.name
    name                       = "deny-http"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

}
resource "azurerm_network_security_rule" "allow_https" {
  resource_group_name         = azurerm_resource_group.this.name
  network_security_group_name = azurerm_network_security_group.spoke_dev.name
    name                       = "allow-https"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.0.0.0/16"
    destination_address_prefix = "*"

}