# Cloud Run -------------------------------------
# -----------------------------------------------
# She is a runner, she is a tracker star, now up in the clouds

resource "google_cloudfunctions2_function" "cloud_run_2nd_gen_fastapi_static_app" {
  name        = "cloud-function-hello-http"
  location    = var.gcp_region
  description = "A simple cloud run function, to return a response back"
  project     = google_project.project.project_id

  build_config {
    runtime     = "python312"
    entry_point = "hello_http"

    source {
      storage_source {
        bucket = google_storage_bucket.app_engine_zip_bucket.name
        object = google_storage_bucket_object.upload_cloud_function_http_framework.name
      }
    }
  }

  service_config {
    max_instance_count = 1
    available_memory   = "512M"
    timeout_seconds    = 60

    # Allow unauthenticated requests if your app is public.
    # Alternatively, configure IAM authentication separately.
    # all_traffic_on_latest_revision = true
  }

  depends_on = [google_storage_bucket_object.upload_cloud_function_http_framework]
}
