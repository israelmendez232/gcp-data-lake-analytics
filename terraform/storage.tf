# GCS resources
resource "google_storage_bucket" "data-lake-storage" {
  name          = "${google_project.data-lake.project_id}-storage"
  project	    = google_project.data-lake.project_id
  location      = var.region
  force_destroy = true
  storage_class = "STANDARD"
}
