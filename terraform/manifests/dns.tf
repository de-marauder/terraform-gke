# DNS A record for mapping load-balancer to application domain
resource "google_dns_record_set" "website" {
  name         = "${local.api_domain}."
  type         = "A"
  ttl          = 300
  managed_zone = var.dns_zone_name
  rrdatas      = [data.kubernetes_service.nginx_ingress.status.0.load_balancer.0.ingress.0.ip]

  provider = google

  depends_on = [
    google_project_service.services
  ]
}
