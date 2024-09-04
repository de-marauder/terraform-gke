variable "project_id" {
  description = "The GKE cluster name"
}

variable "domain" {
  description = "The FQDN for ingress traffic"
}

variable "dns_zone_name" {
  description = "The DNS zone name"
}

variable "email" {
  description = "Email for ingress SSL certification"
}

variable "cluster_name" {
  description = "The GKE cluster name"
}

variable "google_container_cluster" {
  description = "The GKE cluster"
}

variable "region" {
  description = "The GKE cluster region"
}

variable "time_api_name" {
  description = "The name for the time API deployment"
  type        = string
}

variable "time_api_image_tag" {
  description = "The image tag for the time API deployment"
  type        = string
}

variable "time_api_cpu_request" {
  description = "CPU request for the time API container"
  type        = string
  default     = "100m"
}

variable "time_api_cpu_limit" {
  description = "CPU limit for the time API container"
  type        = string
  default     = "500m"
}

variable "time_api_memory_request" {
  description = "Memory request for the time API container"
  type        = string
  default     = "128Mi"
}

variable "time_api_memory_limit" {
  description = "Memory limit for the time API container"
  type        = string
  default     = "256Mi"
}

variable "gcp_svc_key" {
  description = "GCP svc key for terraform"
}