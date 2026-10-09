# App Engine ------------------------------------
# -----------------------------------------------
# App Engine types to be deployed within the project

# You cannot delete this resource after creating, don't rename the variable after creation
resource "google_app_engine_application" "app_engine_fastapi_static_app_top_level" {
  project     = google_project.project.project_id
  location_id = var.gcp_region
}

resource "google_app_engine_standard_app_version" "app_engine_standard_fastapi_static_app" {
  version_id = "v1"
  service    = "default"
  runtime    = "python311"
  project    = google_project.project.project_id

  entrypoint {
    shell = "uvicorn app.main:app --host 0.0.0.0 --port $PORT"
  }

  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.app_engine_zip_bucket.name}/${google_storage_bucket_object.upload_standard_fastapi_static_app.name}"
    }
  }

  automatic_scaling {
    max_concurrent_requests = 10
    min_idle_instances      = 1
    max_idle_instances      = 3
    min_pending_latency     = "1s"
    max_pending_latency     = "5s"
    standard_scheduler_settings {
      target_cpu_utilization        = 0.5
      target_throughput_utilization = 0.75
      min_instances                 = 1
      max_instances                 = 2
    }
  }

  delete_service_on_destroy = true
  service_account           = google_service_account.app_engine_service_account.email

  depends_on = [google_storage_bucket_object.upload_standard_fastapi_static_app]
}

resource "google_app_engine_flexible_app_version" "app_engine_flexible_fastapi_static_app" {
  version_id     = "v2"
  service        = "default-flexible"
  runtime        = "python"
  instance_class = "B1"
  project        = google_project.project.project_id


  flexible_runtime_settings {
    operating_system = "ubuntu22"
    runtime_version  = "3.11"
  }

  network {
    name       = google_compute_network.app_engine_vpc.name
    subnetwork = google_compute_subnetwork.app_engine_subnetwork.name
  }

  entrypoint {
    shell = "uvicorn app.main:app --host 0.0.0.0 --port $PORT"
  }

  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.app_engine_zip_bucket.name}/${google_storage_bucket_object.upload_flexible_fastapi_static_app.name}"
    }
  }

  liveness_check {
    path              = "/"
    check_interval    = "30s"
    timeout           = "4s"
    failure_threshold = 2
    success_threshold = 2
  }

  readiness_check {
    path              = "/"
    check_interval    = "5s"
    timeout           = "4s"
    failure_threshold = 2
    success_threshold = 2
    app_start_timeout = "300s"
  }

  manual_scaling {
    instances = 1
  }


  noop_on_destroy = true
  service_account = google_service_account.app_engine_service_account.email

  depends_on = [
    google_storage_bucket_object.upload_flexible_fastapi_static_app,
    google_project_iam_member.service_account_app_engine_service_account_logs_writer
  ]
}
