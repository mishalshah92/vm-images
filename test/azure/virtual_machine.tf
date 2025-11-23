resource "azurerm_linux_virtual_machine" "linux_machine" {
  name                = "${local.name}-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  # Config
  size     = "Standard_F2"
  priority = "Regular"

  # Identity
  admin_username                  = "ubuntu"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "ubuntu"
    public_key = tls_private_key.rsa_keypair.public_key_openssh
  }

  # Storage
  os_disk {
    name                      = "${local.name}-vm-root"
    caching                   = "ReadWrite"
    storage_account_type      = "Standard_LRS"
    disk_size_gb              = 30
    write_accelerator_enabled = false
  }

  # Network
  network_interface_ids = [
    azurerm_network_interface.linux_machine_nat_interface.id,
  ]

  # Source Image
  source_image_id = data.azurerm_image.app-image.id

  # Others
  tags = local.tags

  provisioner "remote-exec" {

    script = "${path.module}/res/${var.test_script}"

    connection {
      type        = "ssh"
      host        = azurerm_linux_virtual_machine.linux_machine.public_ip_address
      user        = "ubuntu"
      private_key = tls_private_key.rsa_keypair.private_key_pem
    }
  }
}
