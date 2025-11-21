terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "2.2.0"
    }
  }
}

provider "nutanix" {
  endpoint     = var.nutanix_endpoint
  port         = var.nutanix_port
  insecure     = true
  wait_timeout = 10
}