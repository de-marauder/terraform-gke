# Required provider declarations
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.15.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

# kubernetes specific provider declarations
provider "helm" {
  kubernetes {
    host  = "https://${google_container_cluster.shortlet.endpoint}"
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(
      google_container_cluster.shortlet.master_auth[0].cluster_ca_certificate,
    )
  }
}

provider "kubernetes" {
  host  = "https://${google_container_cluster.shortlet.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    google_container_cluster.shortlet.master_auth[0].cluster_ca_certificate,
  )
}

provider "kubectl" {
  host  = "https://${google_container_cluster.shortlet.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    google_container_cluster.shortlet.master_auth[0].cluster_ca_certificate,
  )
  load_config_file = false
}

data "google_client_config" "provider" {}
