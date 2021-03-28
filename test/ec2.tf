resource "aws_instance" "worker-docker-instance" {

  ami           = data.aws_ami.default.id
  instance_type = var.set_instance_type
  instance_initiated_shutdown_behavior = var.set_instance_initiated_shutdown_behavior

  subnet_id = element(tolist(data.aws_subnet_ids.default.ids), 0)
  security_groups = [
    data.aws_security_group.default.id
  ]

  key_name = aws_key_pair.deployer.key_name

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.set_root_volume_size
    delete_on_termination = true
  }

  timeouts {
    create = "60m"
    update = "60m"
    delete = "30m"
  }

  volume_tags = local.tags
  tags = local.tags

  provisioner "remote-exec" {

    script = "${path.module}/app_test.sh"

    connection {
      type        = "ssh"
      host        = aws_instance.worker-docker-instance.private_ip
      user        = "ubuntu"
      private_key = tls_private_key.rsa_keypair.private_key_pem
    }
  }
}