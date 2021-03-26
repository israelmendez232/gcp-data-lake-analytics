# DATASETS
resource "google_bigquery_dataset" "data_warehouse_raw" {
  dataset_id                  = "${var.project_prefix}_raw"
  friendly_name               = "raw"
  location                    = var.region

  labels = {
    env = var.environment
  }

  access {
    role = "OWNER"
  }
}

resource "google_bigquery_dataset" "data_warehouse_trusted" {
  dataset_id                  = "${var.project_prefix}_trusted"
  friendly_name               = "trusted"
  location                    = var.region

  labels = {
    env = var.environment
  }

  access {
    role =  "OWNER"
  }
  access {
    role = "WRITER"
  }

}

resource "google_bigquery_table" "table_ltcusd_5m_trusted" {
  dataset_id = google_bigquery_dataset.data_warehouse_trusted.dataset_id
  table_id   = "ltcusd_5m"

  external_data_configuration {
    autodetect = true
    source_format = "PARQUET"
    source_uris = [ "value" ]
    labels = {
        env = var.environment
    }

    hive_partitioning_options {
            mode = "AUTO"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/trusted/ltcusd_5m/"
        }
  }

  time_partitioning {
    type = "DAY"
  }
}
