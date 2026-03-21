variable "environment" {
  type    = string
  default = "dev"
}

variable "project_name" {
  type    = string
  default = "hub-spoke"
}

variable "location" {
  type    = string
  default = "Polandcentral"
}


variable "address_space" {
  type = map(object({
    address_space = list(string)
    subnets = map(object({
      address_prefix = string
    }))
  }))
  default = {
    hub = {
      address_space = ["10.0.0.0/16"]
      subnets = {
        AzureFirewallSubnet = { address_prefix = "10.0.1.0/24" }
      }
    }
    spoke-dev = {
      address_space = ["10.1.0.0/16"]
      subnets = {
        workload          = { address_prefix = "10.1.1.0/24" }
        private-endpoints = { address_prefix = "10.1.2.0/24" }
      }
    }
    spoke-prod = {
      address_space = ["10.2.0.0/16"]
      subnets = {
        workload = { address_prefix = "10.2.1.0/24" }
      }
    }
  }
}