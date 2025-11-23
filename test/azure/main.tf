terraform {
  required_version = "> 0.13"
}

provider "azurerm" {
  features {}
}

locals {

  name = "app-azure-image-test"

  default_tags = {
    Customer = var.customer
    Owner    = var.owner
    Env      = var.env
    Email    = var.email
    Repo     = var.repo
    Tool     = var.tool
  }

  tags = merge(local.default_tags, var.tags)
}
