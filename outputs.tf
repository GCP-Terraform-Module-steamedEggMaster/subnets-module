output "subnetwork_id" {
  description = "The ID of the created subnetwork"
  value       = google_compute_subnetwork.private.id
}

output "subnetwork_name" {
  description = "The name of the created subnetwork"
  value       = google_compute_subnetwork.private.name
}

output "subnetwork_self_link" {
  description = "The self-link of the created subnetwork"
  value       = google_compute_subnetwork.private.self_link
}

output "subnetwork_region" {
  description = "The region of the created subnetwork"
  value       = google_compute_subnetwork.private.region
}

output "subnetwork_network" {
  description = "The network ID of the created subnetwork"
  value       = google_compute_subnetwork.private.network
}