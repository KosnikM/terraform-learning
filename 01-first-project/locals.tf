locals {
  name_prefix = "learn-${var.environment}"
  vm_size     = var.environment == "prod" ? "Standard_D2s_v3" : "Standard_B1s"
}