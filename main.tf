module "kind_cluster" {
  source = "github.com/den-vasyliev/tf-kind-cluster"
}

# module "google_cluster" {
#   source = "github.com/den-vasyliev/tf-google-gke-cluster"
#   GOOGLE_REGION = var.GOOGLE_REGION
#   GOOGLE_PROJECT = var.GOOGLE_PROJECT
#   GKE_NUM_NODES = var.GKE_NUM_NODES
#   GKE_MACHINE_TYPE = var.GKE_MACHINE_TYPE
# }

module "github_repository" {
  source = "github.com/den-vasyliev/tf-github-repository"
  repository_name   = var.GITHUB_REPO
  github_owner      = var.GITHUB_OWNER
  github_token      = var.GITHUB_TOKEN
  public_key_openssh = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux0"
}

resource "local_file" "kubeconfig" {
  content = templatefile("${path.module}/kubeconfig-kind.tpl", {
    server_endpoint = module.kind_cluster.endpoint,
    cluster_ca      = base64encode(module.kind_cluster.ca),
    client_crt      = base64encode(module.kind_cluster.crt),
    client_key      = base64encode(module.kind_cluster.client_key)
  })
  # content = templatefile("${path.module}/kubeconfig-google.tpl", {
  #   cluster_endpoint = module.google_cluster.config_host,
  #   cluster_ca       = base64encode(module.google_cluster.config_ca),
  #   cluster_name     = module.google_cluster.name,
  #   access_token     = module.google_cluster.config_token
  # })
  filename = "${path.module}/.kubeconfig"
}

module "flux_bootstrap" {
  source            = "github.com/den-vasyliev/tf-fluxcd-flux-bootstrap"
  github_repository = "${var.GITHUB_OWNER}/${var.GITHUB_REPO}"
  github_token      = "${var.GITHUB_TOKEN}"
  private_key       = module.tls_private_key.private_key_pem
  config_path       = local_file.kubeconfig.filename
}

module "tls_private_key" {
  source    = "github.com/den-vasyliev/tf-hashicorp-tls-keys"
  algorithm = "RSA"
}

# module "gke-workload-identity" {
#   source = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
#   use_existing_k8s_sa = true
#   name = "kustomize-controller"
#   namespace = "flux-system"
#   project_id = var.GOOGLE_PROJECT
#   location   = var.GOOGLE_REGION
#   cluster_name = module.google_cluster.name
#   annotate_k8s_sa = true
#   roles = [
#     "roles/cloudkms.cryptoKeyEncrypterDecrypter",
#     "roles/secretmanager.secretAccessor"
#   ]
# }

# module "kms" {
#   source = "github.com/monakhovm/terraform-google-kms"
#   project_id = var.GOOGLE_PROJECT
#   keyring = var.KMS_KEYRING
#   location = "global"
#   keys = [var.KMS_KEY]
#   prevent_destroy = false
# }

# resource "google_kms_crypto_key_iam_member" "sops_key_encrypter" {
#   crypto_key_id = "projects/${var.GOOGLE_PROJECT}/locations/global/keyRings/${var.KMS_KEYRING}/cryptoKeys/${var.KMS_KEY}"
#   role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
#   member        = "serviceAccount:kustomize-controller@${var.GOOGLE_PROJECT}.iam.gserviceaccount.com"
# }
