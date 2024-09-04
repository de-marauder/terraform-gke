module "shortlet-gke" {
  source = "./shortlet-gke"

  project_id = var.project_id

  region = var.region

  cluster_name        = var.cluster_name
  http_whitelist_cidr = var.http_whitelist_cidr
  authorized_network  = var.authorized_network

  domain        = var.domain
  email         = var.email
  dns_zone_name = var.dns_zone_name

  slack_auth_token = var.slack_auth_token

  providers = {
    google = google
  }
}
