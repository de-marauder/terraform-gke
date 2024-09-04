# Custom VPC configurations
resource "google_compute_network" "main" {
  name                            = "${var.project_name}-vpc"
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = false

  depends_on = [
    google_project_service.services["compute"],
    google_project_service.services["container"],
    google_project_service.services["cloudresourcemanager"],
    google_project_service.services["logging"],
  ]
}
