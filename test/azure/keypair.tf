resource "tls_private_key" "rsa_keypair" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}