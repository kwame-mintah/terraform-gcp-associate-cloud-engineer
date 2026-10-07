# Policies --------------------------------------
# -----------------------------------------------
# Arbitrary policy restrictions to demonstrate various levels they can be set.

# Cloud Storage detailed audit logging is enforced throughout the organisation.
resource "google_org_policy_policy" "org_enforce_storage_audit_logging" {
  name   = "${data.google_organization.org.id}/policies/gcp.detailedAuditLoggingMode"
  parent = data.google_organization.org.id

  spec {
    rules {
      enforce = true
    }
  }

  # ADC setting quota isn't picked up as expected for Org V2 calls,
  # Will need to manually set this and retry again on first attempt.
  # e.g export GOOGLE_CLOUD_QUOTA_PROJECT=google_project.project.project_id
  depends_on = [google_project.project]
}


resource "google_folder_organization_policy" "folder_restrict_resource_location" {
  folder     = google_folder.environment_folder.name
  constraint = "constraints/gcp.resourceLocations"

  list_policy {
    allow {
      values = [
        "in:${var.gcp_region}-locations"
      ]
    }
  }
}

# Control whether container images are allowed to be deployed based on security policies.
resource "google_org_policy_policy" "project_gke_require_binary_auth" {
  name   = "projects/${google_project.project.project_id}/policies/container.managed.enableBinaryAuthorization"
  parent = "projects/${google_project.project.project_id}"

  spec {
    rules {
      enforce = "TRUE"
    }
  }

  # ADC setting quota isn't picked up as expected for Org V2 calls,
  # Will need to manually set this and retry again on first attempt.
  # e.g export GOOGLE_CLOUD_QUOTA_PROJECT=google_project.project.project_id
  depends_on = [google_project.project]
}
