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

resource "libvirt_volume" "worker_disk" {
  name   = "ubuntu-arm64-worker.qcow2"
  pool   = "default"
  source = "/var/lib/libvirt/images/ubuntu-arm64-worker.qcow2"
}

resource "libvirt_volume" "db_disk" {
  name   = "ubuntu-arm64-db.qcow2"
  pool   = "default"
  source = "/var/lib/libvirt/images/ubuntu-arm64-db.qcow2"
}

resource "libvirt_domain" "worker" {
  name   = "worker-vm"
  memory = 2048
  vcpu   = 2

  arch    = "aarch64"
  machine = "virt"
  type    = "qemu"

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = libvirt_volume.worker_disk.id
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
}

resource "libvirt_domain" "db" {
  name   = "db-vm"
  memory = 2048
  vcpu   = 2

  arch    = "aarch64"
  machine = "virt"
  type    = "qemu"

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = libvirt_volume.db_disk.id
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
}