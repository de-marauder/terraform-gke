variable "project_name" {
  default = "shortlet-app"
}

variable "project_id" {
  description = "GCP Project ID"
}

variable "region" {
}

variable "cluster_name" {
}

// Subnet names
variable "private" {
  default = "private"
}
variable "pod_ip_cidr_name" {
  default = "k8s-pod-range"
}
variable "service_ip_cidr_name" {
  default = "k8s-service-range"
}

// Network CIDR ranges
variable "private_ip_cidr" {
  default = "10.0.0.0/18"
}
variable "pod_ip_cidr" {
  default = "10.48.0.0/14"
}
variable "service_ip_cidr" {
  default = "10.52.0.0/20"
}
variable "cluster_private_ip_cidr" {
  default = "172.16.0.0/28"
}
variable "http_whitelist_cidr" {
}
variable "authorized_network" {
}

// Compute resources
variable "general_node_pool_machine_type" {
  default = "e2-small"
}
variable "general_num_nodes" {
  default = 2
}
variable "spot_node_pool_machine_type" {
  default = "e2-small"
}

// Images tags
variable "time_api_name" {
  description = "The name for the time API deployment"
  type        = string
  default     = "time-api"
}
variable "time_api_image_tag" {
  description = "The image tag for the time API deployment"
  type        = string
  default     = "latest"
}

// resource limits
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

# DNS parameters
variable "domain" {
  description = "The FQDN for ingress traffic"
}

variable "dns_zone_name" {
  description = "The DNS zone name"
}

variable "email" {
  description = "Email for ingress SSL certification"
}

# Notification channel parameters
variable "slack_auth_token" {
  description = "Slack authentication token for notifications"
  type        = string
  sensitive   = true
}