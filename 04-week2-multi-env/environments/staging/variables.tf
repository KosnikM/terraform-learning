variable "environment" {
  type = string
  default = "staging"
}

variable "project_name" {
  type = string
  default = "multi-env"
}

variable "subnets" {
  type = map(object({
   address_prefix = string
  }))
}