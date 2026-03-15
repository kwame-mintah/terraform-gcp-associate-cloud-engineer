# Data source to get project details
data "google_project" "project" {}

resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"
  depends_on      = [data.google_project.project]
}

resource "google_project_service" "project_dependant_services" {
  project = data.google_project.project.id
  service = "cloudresourcemanager.googleapis.com"

  disable_dependent_services = true
  depends_on                 = [time_sleep.wait_30_seconds]
}
