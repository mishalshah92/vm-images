resource "tls_private_key" "rsa_keypair" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "aws_key_pair" "deployer" {
  key_name   = local.name
  public_key = tls_private_key.rsa_keypair.public_key_openssh

  tags = local.tags
}