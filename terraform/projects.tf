# SETTING UP THE PRODUCTION PROJECTS
resource "google_project" "data-lake" {
  name       = "Data Lake"
  project_id = "data-lake-${local.environment}"
  billing_account = "" # Replace with your billing ID
}

resource "google_project" "data-warehouse" {
  name       = "Data Warehouse"
  project_id = "data-warehouse-${local.environment}"
  billing_account = "" # Replace with your billing ID
}

resource "google_project" "integration-deployment" {
  name       = "Integration Deployment"
  project_id = "integration-deployment-${local.environment}"
  billing_account = "" # Replace with your billing ID
}

resource "google_project" "etl" {
  name       = "ETL"
  project_id = "etl-${local.environment}"
  billing_account = "" # Replace with your billing ID
}
