data "aws_caller_identity" "current" {}

data "aws_ami" "default" {
  most_recent = true
  owners = [
    data.aws_caller_identity.current.account_id
  ]

  filter {
    name   = "tag:Name"
    values = list("${var.image}-image*")
  }
}


data "aws_vpc" "default" {
  tags = {
    "Name" = "vpc"
  }
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    "Name" = "vpc-app*"
  }
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  tags = {
    Name = "dev-vpn"
  }
}