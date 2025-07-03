terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "~> 1.5.0"
    }
    kind = {
      source  = "tehcyx/kind"
      version = "0.8.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "kubernetes" {
  config_path = local_file.kubeconfig.filename
}