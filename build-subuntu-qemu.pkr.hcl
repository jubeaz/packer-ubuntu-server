build {
  #sources = ["source.virtualbox-iso.archlinux"]
  sources = ["source.qemu.subuntu"]

  provisioner "shell" {
    environment_vars =[
        "HTTPSRV=${build.PackerHTTPIP}:${build.PackerHTTPPort}"
    ]
    execute_command = "{{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    script          = "scripts/install-cloudinit.sh"
  }

}
