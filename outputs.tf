output "ip_cp" {
  value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}

output "ip_worker" {
  value = google_compute_instance.worker.network_interface.0.access_config.0.nat_ip
}
