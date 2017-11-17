

variable "name" {
  type = "string"
  default = "bastion"
}

variable "package" {
  type = "string"
  default = "g4-highcpu-1G"
}

variable "networks" {
  type = "list"
}

variable "private_key" {
  type = "string"
}

