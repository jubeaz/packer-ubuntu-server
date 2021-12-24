# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "qemu" "subuntu" {
  accelerator      = "kvm"
  boot_command     = [
    # Make the language selector appear...
    "<up><wait>",
    # ...then get rid of it
    " <up><wait><esc><wait>",
    # Go to the other installation options menu and leave it
    "<f6><wait><esc><wait>",
    # Remove the kernel command-line that already exists
    # "/casper/vmlinuz ",
    # "initrd=/casper/initrd ",
    "<bs><bs><bs><bs>",
    " net.ifnames=0 biosdevname=0 ",
    "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    "<enter>"
    ]
  boot_wait        = "2s"
  cpus             = "${var.cpu}"
  disk_interface   = "virtio"
  disk_size        = "${var.disk_size}"
  format           = "qcow2"
  headless         = "${var.headless}"
  http_content     = {
    "/cloud/cloud.cfg" = templatefile(
                     "${path.root}/srv/cloud/cloud.cfg.pkrtpl",
                     {
                       ansible_login = "${var.ansible_login}"
                       ansible_key = "${var.ansible_key}"
                       ufw_allow_ssh_ip = "${var.ufw_allow_ssh_ip}"
                       ntp_pools = "${var.ntp_pools}"
                       locale = "${var.locale}"
                     }
                   )

    "/user-data" = templatefile(
                     "${path.root}/srv/user-data.pkrtpl",
                     {
                       locale = "${var.locale}",
                       keymap = "${var.keymap}",
                       hostname = "${var.hostname}",
                       packer_passwd = "${var.packer_password}"
                     }
                   )
    "/meta-data" = file("srv/meta-data")
  }
  #http_directory   = "srv"
  iso_checksum     = "${local.iso_checksum_type}:${local.iso_checksum}"
  iso_url          = "${local.iso_url}"
  memory           = "${var.ram}"
  net_device       = "virtio-net"
  qemu_binary      = "qemu-system-x86_64"
  shutdown_command = "${var.shutdown_command}"
  ssh_password     = "ubuntu"
  #ssh_password     = "${var.packer_password}"
  ssh_timeout      = "${var.ssh_timeout}"
  ssh_username     = "packer"
  vm_name          = "${local.vm_name}.qcow2"
  output_directory = "${var.qemu_out_dir}/packer/qemu/${local.vm_name}"
}

