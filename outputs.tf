# Outputs ----------------------------------------
# -----------------------------------------------
# Project and infrastructure deployment outputs

output "gcp_project_number" {
  description = <<-EOF
    The numeric identifier of the project.
  EOF

  value = google_project.project.number
}

output "cloud_run_2nd_gen_fastapi_static_app_url" {
  description = <<-EOF
    The HTTPS endpoint URL to access the 2nd generation Cloud Function / Cloud Run service.
  EOF

  value = google_cloudfunctions2_function.cloud_run_2nd_gen_fastapi_static_app.url
}

output "app_engine_subnetwork_ip_cidr_range" {
  description = <<-EOF
    The primary IPv4 address range (CIDR block) allocated to the App Engine subnetwork in network.tf.
  EOF

  value = google_compute_subnetwork.app_engine_subnetwork.ip_cidr_range
}

output "app_engine_subnetwork_gateway_address" {
  description = <<-EOF
    The gateway IPv4 address of the App Engine subnetwork in network.tf.
  EOF

  value = google_compute_subnetwork.app_engine_subnetwork.gateway_address
}

output "app_engine_service_account_email" {
  description = <<-EOF
    The email address of the custom service account created for App Engine.
  EOF

  value = google_service_account.app_engine_service_account.email
}

output "app_engine_zip_bucket_name" {
  description = <<-EOF
    The name of the Google Cloud Storage bucket storing App Engine deployment zip archives and Cloud Function source.
  EOF

  value = google_storage_bucket.app_engine_zip_bucket.name
}

output "app_engine_default_hostname" {
  description = <<-EOF
    The default hostname of the App Engine application.
  EOF

  value = google_app_engine_application.app_engine_fastapi_static_app_top_level.default_hostname
}

output "app_engine_standard_url" {
  description = <<-EOF
    The accessible URL for the standard App Engine FastAPI application (default service).
  EOF

  value = "https://${google_app_engine_application.app_engine_fastapi_static_app_top_level.default_hostname}"
}

# output "app_engine_flexible_url" {
#   description = <<-EOF
#     The accessible URL for the flexible App Engine FastAPI application (default-flexible service).
#   EOF

#   value = "https://${google_app_engine_flexible_app_version.app_engine_flexible_fastapi_static_app.service}-dot-${google_app_engine_application.app_engine_fastapi_static_app_top_level.default_hostname}"
# }
