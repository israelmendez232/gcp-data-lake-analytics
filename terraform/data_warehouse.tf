resource "google_bigquery_dataset" "data_warehouse" {
  dataset_id                  = "gcp-data-lake-analytics_raw"
  friendly_name               = "raw"
  location                    = var.region
  default_table_expiration_ms = 3600000 # TODO: see if it's necessary to remove this later.

  labels = {
    env = var.environment
  }

  access {
    role          = "admin"
  }
}

resource "google_bigquery_dataset" "data_warehouse" {
  dataset_id                  = "gcp-data-lake-analytics_trusted"
  friendly_name               = "trusted"
  location                    = var.region
  default_table_expiration_ms = 3600000 # TODO: see if it's necessary to remove this later.

  labels = {
    env = var.environment
  }

  access {
    role          = "admin"
  }
  access {
    role          = "advanced"
  }
}

resource "google_bigquery_dataset" "data_warehouse" {
  dataset_id                  = "gcp-data-lake-analytics_analytics"
  friendly_name               = "analytics"
  location                    = var.region
  default_table_expiration_ms = 3600000 # TODO: see if it's necessary to remove this later.

  labels = {
    env = var.environment
  }

  access {
    role          = "admin"
  }
  access {
    role          = "advanced"
  }
  access {
    role          = "essencial"
  }
}
