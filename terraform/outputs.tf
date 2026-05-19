output "worker_vm" {
  value = libvirt_domain.worker.name
}

output "db_vm" {
  value = libvirt_domain.db.name
}