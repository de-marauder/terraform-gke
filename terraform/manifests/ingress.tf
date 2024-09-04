# NGINX Ingress Controller for routing traffic to the application pods 
resource "helm_release" "nginx_ingress" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true

  values = [
    <<-EOT
    controller:
      config:
        compute-full-forwarded-for: "true"
        use-forwarded-headers: "true"
        proxy-body-size: "0"
      ingressClassResource:
        name: external-nginx
        enabled: true
        default: false
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
                - key: app.kubernetes.io/name
                  operator: In
                  values:
                    - ingress-nginx
            topologyKey: "kubernetes.io/hostname"
      replicaCount: 1
      admissionWebhooks:
        enabled: false
      service:
        annotations:
          cloud.google.com/load-balancer-type: External
      metrics:
        enabled: false
    EOT
  ]

  depends_on = [
    time_sleep.wait_for_kubernetes,
  ]
}

# Get the IP address of the ingress load balancer
data "kubernetes_service" "nginx_ingress" {
  metadata {
    name      = "${helm_release.nginx_ingress.name}-controller"
    namespace = helm_release.nginx_ingress.namespace
  }

  depends_on = [
    kubernetes_service.time_api,
    helm_release.nginx_ingress,
    time_sleep.wait_for_kubernetes
  ]
}


# Ingress resource for the date API
resource "kubernetes_ingress_v1" "time_api" {
  metadata {
    name      = "${var.time_api_name}-ingress"
    namespace = kubernetes_namespace.time_api.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class"              = "external-nginx"
      "cert-manager.io/cluster-issuer"           = "letsencrypt-prod"
      "nginx.ingress.kubernetes.io/ssl-redirect" = "false"
    }
  }

  spec {
    ingress_class_name = "external-nginx"
    tls {
      hosts       = [local.api_domain]
      secret_name = "${var.time_api_name}-tls"
    }

    rule {
      host = local.api_domain
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.time_api.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

locals {
  api_sub_domain = "${var.time_api_name}"
  api_domain = "${local.api_sub_domain}.${var.domain}"
}
