resource "google_cloudbuild_trigger" "gcp-data-lake-analytics-etl" {
    github {
        dir         = "/app"
        branch_name = "main"
        owner       = "israelmendez232"
        name        = var.project_prefix
    }

  filename          = "cloudbuild.yaml"
}
