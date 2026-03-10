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

variable "subnet_name" {
  type = string
}

variable "subnet_address_prefix" {
  type    = string
  default = "10.0.1.0/24"
}

variable "nsg_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {

  }
}