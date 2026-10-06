# Buckets ---------------------------------------
# -----------------------------------------------
# Don't keep all your eggs in one bucket.

#trivy:ignore:gcp-0066
resource "google_storage_bucket" "app_engine_zip_bucket" {
  #checkov:skip=CKV_GCP_62:out of scope for this demostration.
  name                     = "app-engine-static-content-${local.org_suffix}"
  location                 = var.gcp_region
  project                  = google_project.project.project_id
  storage_class            = "STANDARD"
  public_access_prevention = "enforced"
  force_destroy            = true
  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "upload_flexible_fastapi_static_app" {
  name   = "app-flexible.zip"
  bucket = google_storage_bucket.app_engine_zip_bucket.name
  source = "./app-engine/app-flexible.zip"
}

resource "google_storage_bucket_object" "upload_standard_fastapi_static_app" {
  name   = "app-standard.zip"
  bucket = google_storage_bucket.app_engine_zip_bucket.name
  source = "./app-engine/app-standard.zip"
}
