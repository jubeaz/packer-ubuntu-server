# https://www.packer.io/docs/templates/hcl_templates/variables#type-constraints for more info.
# #################
# DISK INFO
# #################

variable "hostname" {
  type    = string
  default = "ubuntu"
}

variable "keymap" {
  type    = string
  default = "fr"
}

variable "locale" {
  type    = string
  default = "en_US.UTF-8"
}
variable "distro" {
  type    = string
  default = "ubuntu"
}
# #################
# USER INFO
# #################

variable "packer_password" {
  type      = string
  default   = "packer"
  sensitive = true
}

# #################
#  VM DATA
# #################

variable "cpu" {
  type    = string
  default = "2"
}

variable "ram" {
  type    = string
  default = "2048"
}

variable "disk_size" {
  type    = string
  default = "20480"
}

# #################
#  VM DATA
# #################

variable "headless" {
  type    = string
  default = "true"
}
variable "shutdown_command" {
  type    = string
  default = "sudo systemctl start poweroff.timer"
}

variable "ssh_timeout" {
  type    = string
  default = "20m"
}

variable "qemu_out_dir" {
  type    = string
}
# The "legacy_isotime" function has been provided for backwards compatability, but we recommend switching to the timestamp and formatdate functions.

# All locals variables are generated from variables that uses expressions
# that are not allowed in HCL2 variables.
# Read the documentation for locals blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/locals
locals {
  iso_base_url     = "http://cdimage.ubuntu.com/ubuntu-legacy-server/releases/20.04/release"
# iso_url          = "${local.iso_base_url}/ubuntu-20.04.1-legacy-server-amd64.iso"
#  iso_checksum     = "f11bda2f2caed8f420802b59f382c25160b114ccc665dbac9c5046e7fceaced2"
  iso_checksum_type = "sha256"
  iso_url          = "https://releases.ubuntu.com/20.04/ubuntu-20.04.3-live-server-amd64.iso"
  iso_checksum     = "f8e3086f3cea0fb3fefb29937ab5ed9d19e767079633960ccb50e76153effc98"
  version          = "${legacy_isotime("2006.01")}"
  vm_name          = "subuntu-${var.distro}-${local.version}"
}

