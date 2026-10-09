# Network ---------------------------------------
# -----------------------------------------------
# Connect the dots was fun as a kid, but not now

resource "google_compute_network" "app_engine_vpc" {
  #checkov:skip=CKV2_GCP_18:out of scope for this demonstration.
  name                    = "app-engine-vpc"
  project                 = google_project.project.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "app_engine_subnetwork" {
  name                     = "app-engine-subnet-${var.gcp_region}"
  project                  = google_project.project.project_id
  region                   = var.gcp_region
  network                  = google_compute_network.app_engine_vpc.id
  ip_cidr_range            = "10.10.0.0/24"
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

  depends_on = [
    google_folder_organization_policy.folder_restrict_resource_location
  ]
}
