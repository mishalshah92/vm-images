variable "region" {
  type = string
}

variable "set_instance_type" {
  default = "m5.large"
}

variable "set_instance_initiated_shutdown_behavior" {
  default = "stop"
}

variable "set_root_volume_size" {
  default = "30"
}

variable "set_root_delete_on_termination" {
  default = true
}

variable "image" {
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