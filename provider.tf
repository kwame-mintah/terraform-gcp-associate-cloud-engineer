# Configure the GCP Provider
provider "google" {
  project        = var.gcp_project
  region         = var.gcp_region
  zone           = var.gcp_zone
  default_labels = var.gcp_default_labels
}


# Configure G Suite provider
# TODO: Investigate properly setting up this provider to create google groups:
# https://registry.terraform.io/providers/hashicorp/googleworkspace/latest/docs
# provider "googleworkspace" {
#   credentials             = file(var.google_workspace_credentials)
#   customer_id             = ""
#   impersonated_user_email = ""

#   oauth_scopes = [
#     "https://www.googleapis.com/auth/admin.directory.group",
#   ]
# }
