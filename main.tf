module "gke_cluster" {
  source         = "github.com/monakhovm/tf-google-gke-cluster"
  GOOGLE_REGION  = var.GOOGLE_REGION
  GOOGLE_PROJECT = var.GOOGLE_PROJECT
  GKE_NUM_NODES  = var.GKE_NUM_NODES
}

# terraform {
#   backend "gcs" {
#     bucket = "terraform-state-bucket"
#     prefix = "terraform/state"
#   }
# }

provider "google" {
  project = var.GOOGLE_PROJECT
  region  = var.GOOGLE_REGION
}
