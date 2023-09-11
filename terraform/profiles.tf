// Create a flatcar-install profile
resource "matchbox_profile" "flatcar-install" {
  name   = "flatcar-install"
  kernel = "/assets/flatcar/${var.os_version}/flatcar_production_pxe.vmlinuz"
  initrd = [
    "/assets/flatcar/${var.os_version}/flatcar_production_pxe_image.cpio.gz",
  ]

  args = [
    "initrd=flatcar_production_pxe_image.cpio.gz",
    "flatcar.config.url=${var.matchbox_http_endpoint}/ignition?uuid=$${uuid}&mac=$${mac:hexhyp}",
    "flatcar.first_boot=yes",
  ]
  container_linux_config = file("butane/flatcar-install.yaml")
}

// Profile to set an k3s initialize remote installer
resource "matchbox_profile" "k3s" {
  name         = "k3s"
  container_linux_config = file("butane/k3s.yaml")
}