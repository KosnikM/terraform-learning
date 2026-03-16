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