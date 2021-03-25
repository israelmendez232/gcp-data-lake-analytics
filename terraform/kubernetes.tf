resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

resource "google_container_cluster" "primary" {
  name     = "gcp-data-lake-analytics-etl"
  location = var.region
  node_config {
    service_account = var.email_admin
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels = {
      env = var.environment
    }
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}
