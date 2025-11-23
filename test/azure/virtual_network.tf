resource "azurerm_virtual_network" "vnet" {
  name                = "${local.name}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space = [
    "10.0.0.0/16"
  ]

  subnet {
    name           = "app-subnet"
    address_prefix = "10.0.0.0/20"
  }

  tags = local.tags
}

resource "azurerm_network_interface" "linux_machine_nat_interface" {
  name                = "${local.name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  enable_ip_forwarding          = false
  enable_accelerated_networking = false
  internal_dns_name_label       = local.name

  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    subnet_id                     = tolist(azurerm_virtual_network.vnet.subnet)[0].id
    public_ip_address_id          = azurerm_public_ip.public_ip.id
    primary                       = true
  }

  tags = local.tags
}