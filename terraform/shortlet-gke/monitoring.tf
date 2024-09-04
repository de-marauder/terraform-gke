# API traffic alert policy for heavy ingress monitoring
resource "google_monitoring_alert_policy" "api_traffic" {
  display_name = "API Traffic Alert"
  combiner     = "OR"
  conditions {
    display_name = "High API Traffic"
    condition_threshold {
      filter = join(" AND ", [
        "resource.type = \"k8s_pod\"",
        "resource.labels.cluster_name = \"${var.cluster_name}\"",
        "resource.labels.namespace_name = \"${var.time_api_name}\"",
        "resource.labels.pod_name = starts_with(\"${var.time_api_name}-\")",
        "metric.type = \"kubernetes.io/pod/network/sent_bytes_count\""
      ])
      duration        = "300s"
      comparison      = "COMPARISON_GT"
      threshold_value = 1000000 # 1 MB per 5 minutes
      aggregations {
        alignment_period     = "300s"
        per_series_aligner   = "ALIGN_RATE"
        cross_series_reducer = "REDUCE_SUM"
        group_by_fields      = ["resource.label.pod_name"]
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.slack.name
  ]
}

# Container CPU and Memory Usage Alert Policy
resource "google_monitoring_alert_policy" "container_resource_usage" {
  display_name = "Container Resource Usage Alert"
  combiner     = "OR"
  conditions {
    display_name = "High Container CPU Usage"
    condition_threshold {
      filter = join(" AND ", [
        "resource.type = \"k8s_container\"",
        "resource.labels.cluster_name = \"${var.cluster_name}\"",
        "resource.labels.namespace_name = \"${var.time_api_name}\"",
        "metric.type = \"kubernetes.io/container/cpu/core_usage_time\""
      ])
      duration        = "300s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0.8 # 80% CPU usage
      aggregations {
        alignment_period     = "300s"
        per_series_aligner   = "ALIGN_RATE"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields      = ["resource.label.container_name"]
      }
    }
  }

  conditions {
    display_name = "High Container Memory Usage"
    condition_threshold {
      filter = join(" AND ", [
        "resource.type = \"k8s_container\"",
        "resource.labels.cluster_name = \"${var.cluster_name}\"",
        "resource.labels.namespace_name = \"${var.time_api_name}\"",
        "metric.type = \"kubernetes.io/container/memory/used_bytes\""
      ])
      duration        = "300s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0.8 * 1024 * 1024 * 1024 # 80% of 1GB (adjust as needed)
      aggregations {
        alignment_period     = "300s"
        per_series_aligner   = "ALIGN_MEAN"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields      = ["resource.label.container_name"]
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.slack.name
  ]
}

# Node CPU and Memory Usage Alert Policy
resource "google_monitoring_alert_policy" "node_resource_usage" {
  display_name = "Node Resource Usage Alert"
  combiner     = "OR"
  conditions {
    display_name = "High Node CPU Usage"
    condition_threshold {
      filter = join(" AND ", [
        "resource.type = \"k8s_node\"",
        "resource.labels.cluster_name = \"${var.cluster_name}\"",
        "metric.type = \"kubernetes.io/node/cpu/allocatable_utilization\""
      ])
      duration        = "300s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0.8 # 80% CPU utilization
      aggregations {
        alignment_period     = "300s"
        per_series_aligner   = "ALIGN_MEAN"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields      = ["resource.label.node_name"]
      }
    }
  }

  conditions {
    display_name = "High Node Memory Usage"
    condition_threshold {
      filter = join(" AND ", [
        "resource.type = \"k8s_node\"",
        "resource.labels.cluster_name = \"${var.cluster_name}\"",
        "metric.type = \"kubernetes.io/node/memory/allocatable_utilization\""
      ])
      duration        = "300s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0.8 # 80% memory utilization
      aggregations {
        alignment_period     = "300s"
        per_series_aligner   = "ALIGN_MEAN"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields      = ["resource.label.node_name"]
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.slack.name
  ]
}

resource "google_monitoring_notification_channel" "email" {
  display_name = "API Alert Email"
  type         = "email"
  labels = {
    email_address = var.email
  }

  depends_on = [
    google_container_cluster.shortlet,
    google_project_service.services["monitoring"]
  ]
}

resource "google_monitoring_notification_channel" "slack" {
  display_name = "API Alert Slack"
  type         = "slack"
  labels = {
    channel_name = "#alerts" # Replace with your Slack channel name
  }
  sensitive_labels {
    auth_token = var.slack_auth_token
  }
  depends_on = [
    google_container_cluster.shortlet,
    google_project_service.services["monitoring"]
  ]
}
