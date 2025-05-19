terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.84.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

provider "google-beta" {
  project = var.project
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

resource "google_app_engine_application" "app" {
  project     = var.project
  location_id = "europe-west"
}


variable "project" {
  type = string
  default = "binancebot-459819"
}
