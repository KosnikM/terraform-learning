resource "azurerm_resource_group" "this" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  for_each            = var.address_space
  name                = "vnet-${each.key}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = each.value.address_space

}

resource "azurerm_virtual_network_peering" "hub_to_spoke_dev" {
  name                      = "peering-${var.project_name}-${var.environment}"
  resource_group_name       = azurerm_resource_group.this.name
  virtual_network_name      = azurerm_virtual_network.this["hub"].name
  remote_virtual_network_id = azurerm_virtual_network.this["spoke-dev"].id
}
resource "azurerm_virtual_network_peering" "spoke_dev_to_hub" {
  name                      = "peering2-${var.project_name}-${var.environment}"
  resource_group_name       = azurerm_resource_group.this.name
  virtual_network_name      = azurerm_virtual_network.this["spoke-dev"].name
  remote_virtual_network_id = azurerm_virtual_network.this["hub"].id
}

resource "azurerm_virtual_network_peering" "hub_to_spoke_prod" {
  name                      = "peering3-${var.project_name}-${var.environment}"
  resource_group_name       = azurerm_resource_group.this.name
  virtual_network_name      = azurerm_virtual_network.this["hub"].name
  remote_virtual_network_id = azurerm_virtual_network.this["spoke-prod"].id
}

resource "azurerm_virtual_network_peering" "spoke_prod_to_hub" {
  name                      = "peering4-${var.project_name}-${var.environment}"
  resource_group_name       = azurerm_resource_group.this.name
  virtual_network_name      = azurerm_virtual_network.this["spoke-prod"].name
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
  name                        = "allow-ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "10.0.0.0/16"
  destination_address_prefix  = "*"

}

resource "azurerm_network_security_rule" "deny_http" {
  resource_group_name         = azurerm_resource_group.this.name
  network_security_group_name = azurerm_network_security_group.spoke_dev.name
  name                        = "deny-http"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"

}
resource "azurerm_network_security_rule" "allow_https" {
  resource_group_name         = azurerm_resource_group.this.name
  network_security_group_name = azurerm_network_security_group.spoke_dev.name
  name                        = "allow-https"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "10.0.0.0/16"
  destination_address_prefix  = "*"

}


resource "azurerm_storage_account" "this" {
  name                          = "storageaccounttolearnmk"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = var.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  public_network_access_enabled = false
}


resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.this.name

}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "Vnetlink_spoke_dev"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = azurerm_virtual_network.this["spoke-dev"].id
}

resource "azurerm_private_endpoint" "storage_blob" {
  name                = "spoke_dev_private_endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.this["spoke-dev-private-endpoints"].id
  private_service_connection {
    name                           = "pe-connection-storage"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_dns_a_record" "storage" {
  name                = azurerm_storage_account.this.name
  zone_name           = azurerm_private_dns_zone.blob.name
  resource_group_name = azurerm_resource_group.this.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.storage_blob.private_service_connection[0].private_ip_address]
}
/*
resource "azurerm_public_ip" "firewall" {
  name                = "pip-firewall-hub"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "this" {
  name                = "fw-hub-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "fw-ip-config"
    subnet_id            = azurerm_subnet.this["hub-AzureFirewallSubnet"].id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }
}

resource "azurerm_firewall_network_rule_collection" "sql" {
  name                = "sql_allow"
  azure_firewall_name = azurerm_firewall.this.name
  resource_group_name = azurerm_resource_group.this.name
  priority            = 101
  action              = "Allow"

  rule {
    name = "sqlallow"

    source_addresses = [
      "10.1.0.0/16",
    ]

    destination_ports = [
      "1433",
    ]

    destination_addresses = [
      "10.2.0.0/16"
    ]

    protocols = [
      "TCP"
    ]
  }
}

resource "azurerm_firewall_application_rule_collection" "microsoft_allow" {
  name                = "testcollection"
  azure_firewall_name = azurerm_firewall.this.name
  resource_group_name = azurerm_resource_group.this.name
  priority            = 102
  action              = "Allow"

  rule {
    name = "testrule"

    source_addresses = [
      "10.2.0.0/16"
    ]

    target_fqdns = [
      "*.microsoft.com",
    ]

    protocol {
      port = "443"
      type = "Https"
    }
  }
}

resource "azurerm_firewall_nat_rule_collection" "dnat_inbound" {
  name                = "dnat-inbound"
  azure_firewall_name = azurerm_firewall.this.name
  resource_group_name = azurerm_resource_group.this.name
  priority            = 103
  action              = "Dnat"

  rule {
    name                  = "web-to-spoke-dev"
    source_addresses      = ["85.14.200.0/24"]
    destination_addresses = [azurerm_public_ip.firewall.ip_address]
    destination_ports     = ["443"]
    translated_address    = "10.1.1.5"
    translated_port       = "443"
    protocols             = ["TCP"]
  }
}
*/
resource "azurerm_key_vault" "this" {
  name                        = "kv-hubspoke-dev-mk"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.this.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = false
  rbac_authorization_enabled = true
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_secret" "sql_connecting_string" {
  name = "sql-connecting"
  value = "Server=10.2.1.5;Database=payments;"
  key_vault_id = azurerm_key_vault.this.id
  
}

resource "azurerm_user_assigned_identity" "app" {
  name                = "id-app-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
}
resource "azurerm_role_assignment" "keyvault_reader" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.app.principal_id
}

resource "azurerm_role_assignment" "current_user_kv" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}
resource "azurerm_role_assignment" "app_rg_reader" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.app.principal_id
}

resource "azurerm_network_interface" "nic_workload" {
name = "nic_workload"
location = var.location
resource_group_name = azurerm_resource_group.this.name
ip_configuration {
  name = "nic_workload_config"
  subnet_id = azurerm_subnet.this["spoke-dev-workload"].id
  private_ip_address_allocation = "Dynamic"
}

}

resource "azurerm_linux_virtual_machine" "VM1" {
  name = "VM1"
  location = var.location
  resource_group_name = azurerm_resource_group.this.name
  size = "Standard_B2ats_v2"
  admin_username = "adminuser"
  admin_ssh_key {
  username   = "adminuser"
  public_key = file("~/.ssh/id_rsa.pub")
}
  network_interface_ids = [
    azurerm_network_interface.nic_workload.id
  ]
    os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  zone = "1"
   identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.app.id]
  }
}
/*
resource "azurerm_virtual_machine_extension" "nginx" {
  name                 = "install-nginx"
  virtual_machine_id   = azurerm_linux_virtual_machine.VM1.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
      "commandToExecute": "sudo apt-get update && sudo apt-get install -y nginx"
    }
  SETTINGS
}
*/