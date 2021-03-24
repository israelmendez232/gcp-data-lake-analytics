resource "google_bigquery_dataset" "data_warehouse" {
  dataset_id                  = "data_warehouse"
  friendly_name               = "data_warehouse_${var.region}"
  location                    = var.region
  default_table_expiration_ms = 3600000

  labels = {
    env = var.environment
  }

  access {
    role          = "WRITER"
    special_group = "projectWriters" 
  }
  access {
    role          = "OWNER"
    special_group = "projectOwners" 
  }
  access {
    role          = "READER"
    special_group = "projectReaders" 
  }
}
