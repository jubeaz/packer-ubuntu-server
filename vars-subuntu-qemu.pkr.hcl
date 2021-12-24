# https://www.packer.io/docs/templates/hcl_templates/variables#type-constraints for more info.
# #################
# DISK INFO
# #################

# #################
# TEMPLATE VARS
# #################
variable "hostname" {
  type    = string
  default = "subuntu"
}

variable "keymap" {
  type    = string
  default = "fr"
}

variable "locale" {
  type    = string
  default = "en_US.UTF-8"
}

variable "template_name" {
  type    = string
  default = "subuntu"
}

variable "packer_password" {
  type      = string
  default   = "packer"
  sensitive = true
}

# #################
# CLOUD-INIT VARS
# #################

variable "ansible_login" {
  type      = string
  sensitive = true
}

variable "ansible_key" {
  type      = string
  sensitive = true
}

variable "ufw_allow_ssh_ip" {
  type      = string
  sensitive = true
}

variable "ntp_pools" {
  type      = string
  sensitive = false
  default   = "0.arch.pool.ntp.org, 1.arch.pool.ntp.org, 2.arch.pool.ntp.org, 3.arch.pool.ntp.org"
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
# BUILD VARS
# #################

variable "headless" {
  type    = string
  default = "true"
}
variable "shutdown_command" {
  type    = string
  default = "sudo shutdown now"
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
#
locals {
  version          = "${legacy_isotime("2006.01")}"
  iso_base_url     = "http://cdimage.ubuntu.com/ubuntu-legacy-server/releases/20.04/release"
  iso_checksum_type = "sha256"
  iso_url          = "https://releases.ubuntu.com/20.04/ubuntu-20.04.3-live-server-amd64.iso"
  iso_checksum     = "f8e3086f3cea0fb3fefb29937ab5ed9d19e767079633960ccb50e76153effc98"
  vm_name          = "${var.template_name}-subuntu-${local.version}"
}
