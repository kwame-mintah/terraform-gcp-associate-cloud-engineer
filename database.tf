# Database --------------------------------------
# -----------------------------------------------
# So many places to store information but TLDR.

resource "google_firestore_database" "database" {
  name             = "gcp-ace-${var.environment}"
  project          = google_project.project.project_id
  location_id      = var.gcp_region
  type             = "FIRESTORE_NATIVE"
  database_edition = "STANDARD"
  deletion_policy  = "DELETE"
}
