output "resource_group" {
  value = azurerm_resource_group.rg.name
}

output "vnet" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet" {
  value = tolist(azurerm_virtual_network.vnet.subnet)[0].id
}

output "public_ip" {
  value = azurerm_linux_virtual_machine.linux_machine.public_ip_address
}

output "private_ip" {
  value = azurerm_linux_virtual_machine.linux_machine.private_ip_address
}

output "vm" {
  value = azurerm_linux_virtual_machine.linux_machine.name
}

output "public_key" {
  value = tls_private_key.rsa_keypair.public_key_openssh
}