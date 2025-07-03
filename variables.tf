# variable "GOOGLE_REGION" {
#   description = "Google Cloud region"
#   type        = string
# }

# variable "GOOGLE_PROJECT" {
#   description = "Google Cloud project ID"
#   type        = string
# }

# variable "GKE_NUM_NODES" {
#   description = "Number of nodes in the GKE cluster"
#   type        = number
#   default     = 2
# }
# variable "GKE_MACHINE_TYPE" {
#   description = "Machine type for GKE nodes"
#   type        = string
#   default     = "g1-small"  
# }

variable "GITHUB_OWNER" {
  description = "GitHub owner (username or organization)"
  type        = string
}

variable "GITHUB_REPO" {
  description = "GitHub repository name for Flux CD"
  type        = string
  # default     = "flux-cd"
  default     = "flux-cd-kind"
}

variable "GITHUB_TOKEN" {
  description = "GitHub token with permissions to push to the repository"
  type        = string
  sensitive   = true
}

# variable "KMS_KEYRING" {
#   description = "Name KMS keyring"
#   type        = string
#   default     = "sops-flux"
# }

# variable "KMS_KEY" {
#   description = "Name KMS key"
#   type        = string
#   default     = "sops-key-flux"
# }
