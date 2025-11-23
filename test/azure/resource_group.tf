resource "azurerm_resource_group" "rg" {
  name     = "${local.name}-${random_integer.priority.result}"
  location = var.location
  tags     = local.tags
}


resource "random_integer" "priority" {
  min = 1
  max = 50000
}