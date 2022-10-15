resource "kubernetes_deployment" "static_web_deployment" {
  metadata {
    name = var.app_name
    labels = {
      App = var.labels_name
    }
  }

  spec {
    replicas = var.number_replicas
    selector {
      match_labels = {
        App = var.labels_name
      }
    }
    template {
      metadata {
        labels = {
          App = var.labels_name
        }
      }
      spec {
        container {
          image             = var.image_id
          name              = var.labels_name
          image_pull_policy = "IfNotPresent"

          port {
            container_port = var.docker_ports[0].internal
          }

          readiness_probe {
            http_get {
              path = "/"
              port = var.docker_ports[0].internal
            }
            initial_delay_seconds = 15
            period_seconds        = 5
          }

          liveness_probe {
            http_get {
              path = "/"
              port = var.docker_ports[0].internal
            }
            initial_delay_seconds = 5
            period_seconds        = 3
          }
        }
      }
    }
  }
}