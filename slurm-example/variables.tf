variable "image" {
  default = "Ubuntu Xenial 16.04 (SWITCHengines)"
}

variable "flavor" {
  default = "m1.small"
}

variable "ssh_key_file" {
  default = "~/.ssh/id_rsa_terraform"
}

variable "ssh_user_name" {
  default = "ubuntu"
}

variable "external_gateway" {
  default = "3cc83f7d-9119-475b-ba17-f3510c7902e8"	
}

variable "pool" {
  default = "public"
}
