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
