# SETTING UP THE PRODUCTION PROJECTS
resource "google_project" "data-lake" {
  name       = "Data Lake"
  project_id = "data-lake-${var.environment}"
  billing_account = "" # Replace with your billing ID
}

resource "google_project" "data-warehouse" {
  name       = "Data Warehouse"
  project_id = "data-warehouse-${var.environment}"
  billing_account = "" # Replace with your billing ID
}

resource "google_project" "integration-deployment" {
  name       = "Integration Deployment"
  project_id = "integration-deployment-${var.environment}"
  billing_account = "" # Replace with your billing ID
}

resource "google_project" "etl" {
  name       = "ETL"
  project_id = "etl-${var.environment}"
  billing_account = "" # Replace with your billing ID
}
