# Variables
variable "name" {
  type = string
}

variable "location" {
  type = string
  default = "polandcentral"
}

variable "tags" {
  type = map(string)
  default = {
    
  }

}