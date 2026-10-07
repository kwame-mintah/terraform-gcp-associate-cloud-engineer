# Service accounts ------------------------------
# -----------------------------------------------
# Its always good to shift responsibility elsewhere

resource "google_service_account" "app_engine_service_account" {
  account_id   = "app-engine-${local.org_suffix}"
  display_name = "A service account for App Engine"
  project      = google_project.project.project_id
}
