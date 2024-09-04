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
    iam                  = "iam.googleapis.com"
    container            = "container.googleapis.com"
    monitoring           = "monitoring.googleapis.com"
    compute              = "compute.googleapis.com"
    cloudresourcemanager = "cloudresourcemanager.googleapis.com"
    logging              = "logging.googleapis.com"
  }
}
