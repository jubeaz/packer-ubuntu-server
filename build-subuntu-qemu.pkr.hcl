build {
  #sources = ["source.virtualbox-iso.archlinux"]
  sources = ["source.qemu.subuntu"]

  post-processor "vagrant" {
    keep_input_artifact = true
    output              = "${var.qemu_out_dir}/output/packer_subuntu_-${local.version}.01.box"
  }
}
