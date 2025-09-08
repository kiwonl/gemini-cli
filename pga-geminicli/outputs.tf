output "vm_name" {
  description = "The name of the VM instance."
  value       = google_compute_instance.vm1.name
}

output "network_name" {
  description = "The name of the VPC network."
  value       = google_compute_network.default.name
}

output "subnetwork_name" {
  description = "The name of the subnetwork."
  value       = google_compute_subnetwork.default.name
}
