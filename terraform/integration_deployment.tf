resource "google_cloudbuild_trigger" "gcp-data-lake-analytics-etl" {
  provider    = google-beta
  description = "Build for the ETL code on GKE"
  filename = "cloudbuild.yaml"

  github {
    owner = "israelmendez232"
    name = "gcp-data-lake-analytics"
    push {
      branch = "^main$"
    }
  }
}
