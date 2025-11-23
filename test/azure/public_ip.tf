resource "azurerm_public_ip" "public_ip" {

  name                = "${local.name}-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = "Dynamic"

  tags = local.tags
}
