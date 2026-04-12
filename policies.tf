# Policies --------------------------------------
# -----------------------------------------------
# Arbitrary policy restrictions to demonstrate various levels they can be set.

# Running into permission issues when applying unsure where to look? (org)
# resource "google_org_policy_policy" "org_vm_no_external_ip_access" {
#   name   = "${data.google_organization.org.name}/policies/compute.vmExternalIpAccess"
#   parent = data.google_organization.org.name

#   spec {
#     rules {
#       enforce = true
#     }
#   }
# }

resource "google_folder_organization_policy" "folder_restrict_kms_resource_location" {
  folder     = google_folder.environment_folder.name
  constraint = "constraints/gcp.resourceLocations"

  list_policy {
    allow {
      values = [
        var.gcp_region
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
