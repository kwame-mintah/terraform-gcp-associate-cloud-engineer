# Policies --------------------------------------
# -----------------------------------------------
# Arbitrary policy restrictions to demonstrate various levels they can be set.

# Unable to apply (?), apply seems to be targeting a unknown project (projects/764086051850)
# the API service (orgpolicy.googleapis.com) has been enabled, also does `name` and `parent`,
# suffix with `organizations/` or not?
# Policy would have reset any custom related configurations for the policy managed below.
# resource "google_org_policy_policy" "org_reset_clear_custom_detailed_audit_logging_mode" {
#   name   = "${data.google_organization.org.id}/policies/gcp.detailedAuditLoggingMode"
#   parent = data.google_organization.org.id

#   spec {
#     reset = true
#   }
# }

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

# Running into permission issues when applying unsure where to look? (org, folder, project)
# resource "google_project_organization_policy" "project_gke_require_binary_auth" {
#   project    = google_project.project.name
#   constraint = "constraints/gke.requireBinaryAuthorization"

#   boolean_policy {
#     enforced = true
#   }
# }
