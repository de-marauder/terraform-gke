# Enable required service APIs
resource "google_project_service" "services" {

  for_each = local.services
  service  = each.value

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = false
}

locals {
  services = {
    domains = "domains.googleapis.com"
    dns = "dns.googleapis.com"
  }
}
