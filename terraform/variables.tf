variable "location" {
  type    = string
  default = "swedencentral"
}

variable "resource_group_name" {
  type    = string
  default = "terrabicep"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for VM login"
}
