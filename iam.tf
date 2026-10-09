# Identity Access Management --------------------
# -----------------------------------------------
# Creating various roles and assign permissions etc.

resource "google_organization_iam_custom_role" "iam_custom_org_iam_role_viewer" {
  count = var.organization_development_group_email_address == "" ? 0 : 1

  org_id      = data.google_organization.org.org_id
  role_id     = "custom_org_iam_role_viewer"
  title       = "Custom Org IAM Role Viewer"
  description = "A role for personal account outside of organisation to view limited resources"
  # Permissions list: https://docs.cloud.google.com/iam/docs/roles-permissions/iam
  permissions = ["iam.roles.list", "iam.roles.get"]
}


resource "google_project_iam_member" "iam_custom_org_iam_role_member" {
  count = var.organization_development_group_email_address == "" ? 0 : 1

  project = google_project.project.project_id
  role    = "organizations/${data.google_organization.org.org_id}/roles/${google_organization_iam_custom_role.iam_custom_org_iam_role_viewer[0].role_id}"
  member  = "group:${var.organization_development_group_email_address}"

  condition {
    title       = "expires_after_31_12_2026"
    description = "Expiring at midnight of 31-12-2026"
    expression  = "request.time < timestamp(\"2027-01-01T00:00:00Z\")"
  }

  depends_on = [google_organization_iam_custom_role.iam_custom_org_iam_role_viewer]
}

resource "google_project_iam_member" "service_account_app_engine_service_account_networkuser" {
  project = google_service_account.app_engine_service_account.project
  role    = "roles/compute.networkUser"
  member  = "serviceAccount:${google_service_account.app_engine_service_account.email}"
}

resource "google_project_iam_member" "service_account_app_engine_service_account_object_viewer" {
  project = google_service_account.app_engine_service_account.project
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.app_engine_service_account.email}"
}

resource "google_project_iam_member" "service_account_app_engine_service_account_logs_writer" {
  project = google_project.project.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.app_engine_service_account.email}"
}

resource "google_storage_bucket_iam_member" "default_app_engine_admin_staging_bucket" {
  bucket = "staging.${google_project.project.project_id}.appspot.com"
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_project.project.project_id}@appspot.gserviceaccount.com"

  depends_on = [
    google_app_engine_application.app_engine_fastapi_static_app_top_level
  ]
}

resource "google_storage_bucket_iam_member" "default_app_engine_service_read_zip_bucket" {
  bucket = google_storage_bucket.app_engine_zip_bucket.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_project.project.project_id}@appspot.gserviceaccount.com"
}

# The cloud build triggered by App Engine assumes this role and not the default cloud build
# role usually found within the project.
resource "google_project_iam_member" "service_account_app_engine_artifact_editor" {
  project = google_project.project.project_id
  role    = "roles/artifactregistry.editor"
  # member  = "serviceAccount:${google_service_account.app_engine_service_account.email}"
  #checkov:skip=CKV_GCP_46:out of scope for this demonstration.
  # Seems the cloud build that is used for deployment uses the default service account and not
  # assuming the created and attached one within Terraform (?), without this, fails the build due to:
  # DENIED: Permission 'artifactregistry.repositories.downloadArtifacts' denied on resource '//artifactregistry.googleapis.com/projects/<project-id>/locations/europe/repositories/eu.gcr.io' (or it may not exist).
  member = "serviceAccount:${google_project.project.project_id}@appspot.gserviceaccount.com"
}

resource "google_artifact_registry_repository_iam_member" "service_account_app_engine_gae_standard_registry_reader" {
  for_each   = toset(["gae-standard", "gae-flexible"])
  project    = google_project.project.project_id
  location   = var.gcp_region
  repository = each.key
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.app_engine_service_account.email}"
}

resource "google_project_iam_member" "cloudbuild_artifactregistry_writer" {
  project = google_project.project.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_project.project.number}@cloudbuild.gserviceaccount.com"
}
