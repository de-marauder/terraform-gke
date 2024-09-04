# Default node pool for general workloads, not preemtiple
resource "google_container_node_pool" "general" {
  name       = "${var.cluster_name}-general"
  cluster    = google_container_cluster.shortlet.id
  node_count = var.general_num_nodes

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = var.general_node_pool_machine_type
    disk_size_gb = 10

    labels = {
      role = "general"
      env  = var.project_id
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

# Node pool for ephemeral workloads, preemtiple
resource "google_container_node_pool" "spot" {
  name    = "${var.cluster_name}-spot"
  cluster = google_container_cluster.shortlet.id

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 0
    max_node_count = 3
  }

  node_config {
    preemptible  = true
    machine_type = var.spot_node_pool_machine_type

    labels = {
      team = "devops"
    }

    taint {
      key    = "instance_type"
      value  = "spot"
      effect = "NO_SCHEDULE"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
