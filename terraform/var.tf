variable "project_id" {
  type        = string
  description = "GCP Project ID"
}
variable "cluster_name" {
  type        = string
  description = "GKE cluster name"
}

variable "http_whitelist_cidr" {
  type        = list(string)
  description = "CIDR range to allow http ingress"
  default     = ["0.0.0.0/0"]
}
variable "authorized_network" {
  type        = string
  description = "CIDR range to allow access to master nodes"
  default     = "0.0.0.0/0"
}


variable "region" {
  type    = string
  default = "us-central1"
}
variable "time_api_image_tag" {
  type        = string
  description = "The FQDN for ingress traffic"
}

# DNS parameters
variable "domain" {
  type        = string
  description = "The FQDN for ingress traffic"
}

variable "dns_zone_name" {
  type        = string
  description = "The DNS zone name"
  default     = "shortlet-zone"
}

variable "email" {
  type        = string
  description = "Email for ingress SSL certification"
}

# Notification channel parameters
variable "slack_auth_token" {
  description = "Slack authentication token for notifications"
  type        = string
  sensitive   = true
}