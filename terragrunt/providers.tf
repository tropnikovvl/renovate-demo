terraform {
  required_version = "1.7.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.59.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "= 2.18.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "= 1.14.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.13.0"
    }
  }
}
