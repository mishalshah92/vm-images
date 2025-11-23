variable "location" {
  type = string
}

variable "image" {
  type = string
}

variable "image_resource_group" {
  type = string
}

variable "test_script" {
  type = string
}

# tags
variable "customer" {
  type = string
}

variable "env" {
  type = string
}

variable "owner" {
  type = string
}

variable "email" {
  type = string
}

variable "repo" {
  type = string
}

variable "tool" {
  description = "Automation tool info"
  default     = "Managed by Terraform"
}

variable "tags" {
  type    = map(string)
  default = {}
}