# GCS resources
resource "google_storage_bucket" "gcs-data-lake-storage" {
  name          = "${google_project.data-lake.project_id}-storage"
  project	    = google_project.data-lake.project_id
  location      = local.region
  force_destroy = true
  storage_class = "STANDARD"
}
