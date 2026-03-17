variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "polandcentral"
}

variable "vnet_name" {
  type = string
}
variable "vnet_address_space" {
  type    = string
  default = "10.0.0.0/16"
}


variable "nsg_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {

  }
}

variable "subnets" {
  type = map(object({
    address_prefix = string
  }))
}


variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}