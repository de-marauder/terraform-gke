# Allow http(s) access
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = var.http_whitelist_cidr
  target_tags   = ["http-server"]
}

# Deny access on all port
resource "google_compute_firewall" "deny_all_ingress" {
  name    = "deny-all-ingress"
  network = google_compute_network.main.name

  deny {
    protocol = "all"
  }

  priority      = 65535
  source_ranges = ["0.0.0.0/0"]
}