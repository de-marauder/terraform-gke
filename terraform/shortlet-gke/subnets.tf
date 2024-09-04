# Private subnet for custom VPC
resource "google_compute_subnetwork" "private" {
  name                     = "private"
  ip_cidr_range            = var.private_ip_cidr
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = var.pod_ip_cidr_name
    ip_cidr_range = var.pod_ip_cidr
  }
  secondary_ip_range {
    range_name    = var.service_ip_cidr_name
    ip_cidr_range = var.service_ip_cidr
  }
}
