# Variables
variable "environment" {
  type    = string
  default = "dev"
}

variable "project_name" {
  type    = string
  default = "week2"
}

variable "subnets" {
    type = map (
        object(
            {
            address_prefix = string
        }
    ))
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