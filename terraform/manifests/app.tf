# Manifests for time api application

resource "kubernetes_namespace" "time_api" {

  depends_on = [
    time_sleep.wait_for_kubernetes,
  ]

  metadata {
    name = var.time_api_name
  }
}

resource "kubernetes_deployment" "time_api" {
  metadata {
    name      = var.time_api_name
    namespace = kubernetes_namespace.time_api.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = var.time_api_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.time_api_name
        }
      }

      spec {
        container {
          # image = "gcr.io/${var.project_id}/time-api:${var.time_api_image_tag}"
          image = "demarauder/time-api:latest"
          name  = var.time_api_name

          port {
            container_port = 8080
          }

          resources {
            requests = {
              cpu    = var.time_api_cpu_request
              memory = var.time_api_memory_request
            }
            limits = {
              cpu    = var.time_api_cpu_limit
              memory = var.time_api_memory_limit
            }
          }
        }
      }
    }
  }
  depends_on = [kubernetes_namespace.time_api]
}

resource "kubernetes_service" "time_api" {
  metadata {
    name      = var.time_api_name
    namespace = kubernetes_namespace.time_api.metadata[0].name
  }

  spec {
    selector = {
      app = "${kubernetes_deployment.time_api.spec[0].template[0].metadata[0].labels.app}"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "ClusterIP"
  }
  depends_on = [kubernetes_namespace.time_api]
}
