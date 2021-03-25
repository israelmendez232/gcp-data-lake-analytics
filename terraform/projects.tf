resource "google_project" "data-lake" {
  name       = var.project_name
  project_id = "gcp-data-lake-analytics-${var.environment}"
  billing_account = "${var.billing_id}"
}
