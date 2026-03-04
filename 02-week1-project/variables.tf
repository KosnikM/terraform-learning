variable "environment" {
 description = "środowisko"
 type = string
 default = "dev2"
}

variable "location" {
  description = "Lokalizacja"
  type = string
  default = "Poland Central"
}

variable "tags" {   
  type = map(string)
  default = {
   Owner = "Maciek"
   Environment = "dev2"
  }
}

variable "resource_group_name" {
  description = "nazwa resource grupy"
  type = string
  default = "project02"
}