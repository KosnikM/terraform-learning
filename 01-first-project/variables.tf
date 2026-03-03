variable "resource_group_name" {
  description = "Nazwa resource grupy"
  type        = string
  default     = "rg-terraform-learn-day1"
}

variable "location" {
  description = "Region Azure"
  type        = string
  default     = "Poland Central"
}

variable "environment" {
  description = "środowisko"
  type        = string
  default     = "dev"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "Learning"
    Owner       = "Maciek"
    Project     = "Terraform-Day1"
    ManagedBy   = "Terraform"

  }
}