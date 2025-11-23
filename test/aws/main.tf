provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 0.14.0"
}

locals {

  name = "${var.service}-ami-test-${data.aws_ami.default.tags["Commit"]}",

  default_tags = {
    Name    = local.name
    Customer = var.customer
    Owner    = var.owner
    Env      = var.env
    Email    = var.email
    Repo     = var.repo
    Tool     = var.tool
  }

  tags = merge(local.default_tags, var.tags)
}
