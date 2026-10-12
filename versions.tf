terraform {
  required_version = ">= 1.5.7, <= 1.9.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.22.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.13.1"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.8.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.9.1"
    }
  }
}
