terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.6"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_volume" "ubuntu-qcow2" {
  name = "ubuntu-arm64.qcow2"
  pool = "default"

  source = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-arm64.img"
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name = "commoninit.iso"
  pool = "default"

  user_data = file("${path.module}/cloud-init.yaml")

  meta_data = <<EOF
instance-id: iid-local01
local-hostname: ubuntu
EOF
}

resource "libvirt_domain" "worker" {
  name   = "worker-vm"
  memory = 2048
  vcpu   = 2
  type   = "qemu"

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = libvirt_volume.ubuntu-qcow2.id
    scsi      = true
  }
}

resource "libvirt_domain" "db" {
  name   = "db-vm"
  memory = 2048
  vcpu   = 2
  type   = "qemu"


  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = libvirt_volume.ubuntu-qcow2.id
    scsi      = true
  }
}