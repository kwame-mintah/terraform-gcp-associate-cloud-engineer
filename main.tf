# Data source to get project details
data "google_project" "project" {}

resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"
  depends_on      = [data.google_project.project]
}

resource "google_project_service" "project_dependant_services" {
  for_each = toset(["cloudresourcemanager.googleapis.com", "cloudidentity.googleapis.com", "serviceusage.googleapis.com"])
  project  = data.google_project.project.id
  service  = each.key

  disable_dependent_services = true
  depends_on                 = [time_sleep.wait_30_seconds]
}

resource "google_folder" "environment_folder" {
  display_name = var.environment
  parent       = "organizations/559580651912"
}
