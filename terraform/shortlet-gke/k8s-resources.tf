# Module for all kubernetes manifest declarations
module "manifests" {
  source = "../manifests"

  project_id               = var.project_id
  google_container_cluster = google_container_cluster.shortlet
  cluster_name             = google_container_cluster.shortlet.name
  region                   = var.region
  time_api_name            = var.time_api_name
  time_api_image_tag       = var.time_api_image_tag

  time_api_cpu_request    = var.time_api_cpu_request
  time_api_cpu_limit      = var.time_api_cpu_limit
  time_api_memory_request = var.time_api_memory_request
  time_api_memory_limit   = var.time_api_memory_limit

  domain        = var.domain
  dns_zone_name = var.dns_zone_name
  email         = var.email

  providers = {
    google     = google
    helm       = helm
    kubernetes = kubernetes
    kubectl    = kubectl
  }
}
