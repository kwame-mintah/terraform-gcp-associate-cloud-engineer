# Create new project within folder in organization

locals {
  org_suffix = substr(md5(var.organization_domain_name), 0, 6)
}

# ```markdown
# └── 🏠 intuitive-judgments.com/
#     └── 📁 development/
#         └── ⚙️ gcp-ace
# ```

data "google_organization" "org" {
  domain = var.organization_domain_name
}

resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"
  depends_on      = [google_project.project]
}

resource "google_folder" "environment_folder" {
  display_name        = var.environment
  parent              = data.google_organization.org.name
  deletion_protection = false
}

resource "google_project" "project" {
  name                = "gcp-ace"
  project_id          = "gcp-ace-2026-${local.org_suffix}"
  folder_id           = google_folder.environment_folder.name
  auto_create_network = false
  billing_account     = var.gcp_billing_account
  labels = {
    organisation = replace(var.organization_domain_name, ".", "-")
    environment  = var.environment
  }
  deletion_policy = "DELETE"
}

resource "google_tags_tag_key" "org_tag_key" {
  parent      = data.google_organization.org.name
  short_name  = "organisation"
  description = "Which organisation the resources belong to."
}

resource "google_tags_tag_value" "org_tag_value" {
  parent      = google_tags_tag_key.org_tag_key.id
  short_name  = var.organization_domain_name
  description = "For organisation resources."
}

resource "google_tags_tag_key" "project_env_tag_key" {
  parent      = google_project.project.id
  short_name  = "environment"
  description = "Which environment the resources belong to."
}

resource "google_tags_tag_value" "project_env_tag_value" {
  parent      = google_tags_tag_key.project_env_tag_key.id
  short_name  = var.environment
  description = "For environment resources."
}

resource "google_project_iam_audit_config" "project_audit" {
  project = google_project.project.id
  service = "allServices"
  audit_log_config {
    log_type = "ADMIN_READ"
  }
  audit_log_config {
    log_type = "DATA_READ"
  }
  audit_log_config {
    log_type = "DATA_WRITE"
  }
}

resource "google_project_service" "project_dependant_services" {
  for_each = toset(["cloudresourcemanager.googleapis.com", "cloudidentity.googleapis.com", "serviceusage.googleapis.com", "orgpolicy.googleapis.com", "cloudkms.googleapis.com", "container.googleapis.com", "appengineflex.googleapis.com", "appengine.googleapis.com"])
  project  = google_project.project.id
  service  = each.key

  disable_dependent_services = true
  depends_on                 = [time_sleep.wait_30_seconds]
}
