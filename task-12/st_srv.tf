resource "kubernetes_service" "st_site_srv" {
  metadata {
    name = "service-static-site"
  }
  spec {
    selector = {
      App = var.labels_name
    }
    port {
      protocol    = var.docker_ports[0].protocol
      node_port   = var.docker_ports[0].external
      port        = var.docker_ports[0].internal
      target_port = var.docker_ports[0].internal
    }

    type             = var.docker_ports[0].typesrv
  }
}