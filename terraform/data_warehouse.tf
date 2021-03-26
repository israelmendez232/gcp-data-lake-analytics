# DATASETS
resource "google_bigquery_dataset" "data_warehouse" {
  dataset_id                  = "gcp-data-lake-analytics_raw"
  friendly_name               = "raw"
  location                    = var.region

  labels = {
    env = var.environment
  }

  access {
    role = "admin"
  }
}

resource "google_bigquery_dataset" "data_warehouse" {
  dataset_id                  = "gcp-data-lake-analytics_trusted"
  friendly_name               = "trusted"
  location                    = var.region

  labels = {
    env = var.environment
  }

  access {
    role = "admin"
  }
  access {
    role = "advanced"
  }

  tables = [
    {
        table_id = "btcusd_5m",
        time_partitioning = {
            type = "DAY"
        },
        labels = {
            env = var.environment
        },
        hive_partitioning_options = {
            mode = "CUSTOM"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/trusted/btcusd_5m/*"
        }
    },
    {
        table_id = "ethusd_5m",
        time_partitioning = {
            type = "DAY"
        },
        labels = {
            env = var.environment
        },
        hive_partitioning_options = {
            mode = "CUSTOM"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/trusted/ethusd_5m/*"
        }
    },
    {
        table_id = "ltcusd_5m",
        time_partitioning = {
            type = "DAY"
        },
        labels = {
            env = var.environment
        },
        hive_partitioning_options = {
            mode = "CUSTOM"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/trusted/ltcusd_5m/*"
        }
    },
    {
        table_id = "xrpusd_5m",
        time_partitioning = {
            type = "DAY"
        },
        labels = {
            env = var.environment
        },
        hive_partitioning_options = {
            mode = "CUSTOM"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/trusted/xrpusd_5m/*"
        }
    }
  ]

}

resource "google_bigquery_dataset" "data_warehouse" {
  dataset_id                  = "gcp-data-lake-analytics_analytics"
  friendly_name               = "analytics"
  location                    = var.region

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

  tables = [
    {
        table_id = "btcusd_5m",
        time_partitioning = {
            type = "DAY"
        },
        labels = {
            env = var.environment
        },
        hive_partitioning_options = {
            mode = "CUSTOM"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/analytics/btcusd_5m/*"
        }
    },
    {
        table_id = "ethusd_5m",
        time_partitioning = {
            type = "DAY"
        },
        labels = {
            env = var.environment
        },
        hive_partitioning_options = {
            mode = "CUSTOM"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/analytics/ethusd_5m/*"
        }
    },
    {
        table_id = "ltcusd_5m",
        time_partitioning = {
            type = "DAY"
        },
        labels = {
            env = var.environment
        },
        hive_partitioning_options = {
            mode = "CUSTOM"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/analytics/ltcusd_5m/*"
        }
    },
    {
        table_id = "xrpusd_5m",
        time_partitioning = {
            type = "DAY"
        },
        labels = {
            env = var.environment
        },
        hive_partitioning_options = {
            mode = "CUSTOM"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/analytics/xrpusd_5m/*"
        }
    }
  ]
}
