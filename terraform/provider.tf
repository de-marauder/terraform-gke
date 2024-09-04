# Provider declaraction with remote state
terraform {
  backend "gcs" {
    bucket = "shortlet-tf-state-bucket"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.0.1"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
