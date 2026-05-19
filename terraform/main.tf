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

resource "libvirt_volume" "ubuntu_qcow2" {
  name = "ubuntu-arm64.qcow2"
  pool = "default"

  source = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-arm64.img"
}

resource "libvirt_domain" "worker" {
  name    = "worker-vm"
  memory  = 2048
  vcpu    = 2

  type    = "qemu"
  machine = "virt"

  qemu_agent = false

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = libvirt_volume.ubuntu_qcow2.id
    scsi      = true
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
}

resource "libvirt_domain" "db" {
  name    = "db-vm"
  memory  = 2048
  vcpu    = 2

  type    = "qemu"
  machine = "virt"

  qemu_agent = false

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = libvirt_volume.ubuntu_qcow2.id
    scsi      = true
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
}