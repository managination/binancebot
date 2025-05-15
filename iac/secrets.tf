resource "google_secret_manager_secret" "default" {
  provider = google-beta
  secret_id = "secret-binance"
  replication {
    user_managed {
      replicas {
        location = "europe-west1"
      }
    }
  }
}

resource "google_secret_manager_secret" "secret-binance-private" {
  provider = google-beta
  secret_id = "secret-binance-private"
  replication {
    user_managed {
      replicas {
        location = "europe-west1"
      }
    }
  }
}
