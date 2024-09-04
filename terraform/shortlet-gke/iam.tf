
# Service account for kubernetes workloads to impersonate and perform GCP operations
resource "google_service_account" "kubernetes" {
  account_id   = "kubernetes"
  display_name = "Kubernetes Service Account"

  depends_on = [
    google_project_service.services["iam"]
  ]
}

# Mapping of required roles to service account
resource "google_project_iam_member" "kubernetes_roles" {
  for_each = toset([
    "roles/storage.admin",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer"
  ])
  role    = each.key
  member  = "serviceAccount:${google_service_account.kubernetes.email}"
  project = var.project_id
}

resource "google_project_iam_member" "kubernetes_container_admin" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.kubernetes.email}"
}
