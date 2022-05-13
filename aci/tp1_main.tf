terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}
provider "azurerm" {
  features {}
}
variable "location" {
  type        = string
  description = "Location of Azure resources"
  default     = "uksouth"
}
variable "resource_group_name" {
  type        = string
  description = "Resource Group name to where resources are going to be deployed"
  default     = "rgn_module05"
}
variable "container_group_name" {
  type        = string
  description = "aci name"
  default     = "nginxmodule05"
}
variable "container_group_dns" {
  type        = string
  description = "aci name"
  default     = "nginxmodule05"
}
resource "azurerm_resource_group" "rg_module05" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_container_group" "cont_module05" {
  name                = var.container_group_name
  resource_group_name = var.resource_group_name
  location            = var.location
  ip_address_type     = "Public"
  dns_name_label      = var.container_group_dns
  os_type             = "Linux"
  container {
    name   = "nginx"
    image  = "nginx:latest"
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
  depends_on = [
    azurerm_resource_group.rg_module05,
  ]
}


