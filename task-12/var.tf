variable "number_replicas" {}
variable "image_id" {}
variable "app_name" {}
variable "labels_name" {}

variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
    typesrv  = string
    
  }))
  default = [
    {
      internal = 80
      external = 30912
      protocol = "TCP"
      typesrv  = "NodePort"
    }
  ]
}

variable "token" {}

variable "path" {
  default = "/vagrant/t12"
}

variable "repo_name" {}

variable "list_of_files" {
    default = [
      "provider.tf",
      "st_dep.tf",
      "st_srv.tf",
      "var.tf",
      "terraform.tfvars",
      "github.tf"
    ]
}