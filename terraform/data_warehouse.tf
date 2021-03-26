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

resource "google_bigquery_dataset" "data_warehouse_analytics" {
  dataset_id                  = "${var.project_prefix}_analytics"
  friendly_name               = "analytics"
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
  access {
    role = "READER"
  }

}

# TABLES
resource "google_bigquery_table" "table_btcusd_5m_raw" {
  provider    = google-beta
  dataset_id = google_bigquery_dataset.data_warehouse_raw.dataset_id
  table_id   = "btcusd_5m"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = var.environment
  }

  external_data_configuration {
    autodetect = true
    source_format = "PARQUET"
    source_uris = [ "gs://${google_project.data-lake.project_id}-storage/raw/btcusd_5m/*" ]

    hive_partitioning_options {
            mode = "AUTO"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/raw/btcusd_5m/*"
    }
  }
}

resource "google_bigquery_table" "table_ethusd_5m_raw" {
  provider    = google-beta
  dataset_id = google_bigquery_dataset.data_warehouse_raw.dataset_id
  table_id   = "ethusd_5m"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = var.environment
  }

  external_data_configuration {
    autodetect = true
    source_format = "PARQUET"
    source_uris = [ "gs://${google_project.data-lake.project_id}-storage/raw/ethusd_5m/*" ]

    hive_partitioning_options {
            mode = "AUTO"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/raw/ethusd_5m/*"
    }
  }

}

resource "google_bigquery_table" "table_ltcusd_5m_raw" {
  provider    = google-beta
  dataset_id = google_bigquery_dataset.data_warehouse_raw.dataset_id
  table_id   = "ltcusd_5m"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = var.environment
  }

  external_data_configuration {
    autodetect = true
    source_format = "PARQUET"
    source_uris = [ "gs://${google_project.data-lake.project_id}-storage/raw/ltcusd_5m/*" ]

    hive_partitioning_options {
            mode = "AUTO"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/raw/ltcusd_5m/*"
    }
  }

}

resource "google_bigquery_table" "table_xrpusd_5m_raw" {
  provider    = google-beta
  dataset_id = google_bigquery_dataset.data_warehouse_raw.dataset_id
  table_id   = "xrpusd_5m"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = var.environment
  }

  external_data_configuration {
    autodetect = true
    source_format = "PARQUET"
    source_uris = [ "gs://${google_project.data-lake.project_id}-storage/raw/xrpusd_5m/*" ]

    hive_partitioning_options {
            mode = "AUTO"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/raw/xrpusd_5m/*"
    }
  }

}

resource "google_bigquery_table" "table_btcusd_5m_trusted" {
  provider    = google-beta
  dataset_id = google_bigquery_dataset.data_warehouse_trusted.dataset_id
  table_id   = "btcusd_5m"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = var.environment
  }

  external_data_configuration {
    autodetect = true
    source_format = "PARQUET"
    source_uris = [ "gs://${google_project.data-lake.project_id}-storage/trusted/btcusd_5m/*" ]

    hive_partitioning_options {
            mode = "AUTO"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/trusted/btcusd_5m/*"
    }
  }
}

resource "google_bigquery_table" "table_ethusd_5m_trusted" {
  provider    = google-beta
  dataset_id = google_bigquery_dataset.data_warehouse_trusted.dataset_id
  table_id   = "ethusd_5m"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = var.environment
  }

  external_data_configuration {
    autodetect = true
    source_format = "PARQUET"
    source_uris = [ "gs://${google_project.data-lake.project_id}-storage/trusted/ethusd_5m/*" ]

    hive_partitioning_options {
            mode = "AUTO"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/trusted/ethusd_5m/*"
    }
  }

}

resource "google_bigquery_table" "table_ltcusd_5m_trusted" {
  provider    = google-beta
  dataset_id = google_bigquery_dataset.data_warehouse_trusted.dataset_id
  table_id   = "ltcusd_5m"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = var.environment
  }

  external_data_configuration {
    autodetect = true
    source_format = "PARQUET"
    source_uris = [ "gs://${google_project.data-lake.project_id}-storage/trusted/ltcusd_5m/*" ]

    hive_partitioning_options {
            mode = "AUTO"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/trusted/ltcusd_5m/*"
    }
  }

}

resource "google_bigquery_table" "table_xrpusd_5m_trusted" {
  provider    = google-beta
  dataset_id = google_bigquery_dataset.data_warehouse_trusted.dataset_id
  table_id   = "xrpusd_5m"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = var.environment
  }

  external_data_configuration {
    autodetect = true
    source_format = "PARQUET"
    source_uris = [ "gs://${google_project.data-lake.project_id}-storage/trusted/xrpusd_5m/*" ]

    hive_partitioning_options {
            mode = "AUTO"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/trusted/xrpusd_5m/*"
    }
  }

}


resource "google_bigquery_table" "table_btcusd_5m_analytics" {
  provider    = google-beta
  dataset_id = google_bigquery_dataset.data_warehouse_analytics.dataset_id
  table_id   = "btcusd_5m"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = var.environment
  }

  external_data_configuration {
    autodetect = true
    source_format = "PARQUET"
    source_uris = [ "gs://${google_project.data-lake.project_id}-storage/analytics/btcusd_5m/*" ]

    hive_partitioning_options {
            mode = "AUTO"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/analytics/btcusd_5m/*"
    }
  }
}

resource "google_bigquery_table" "table_ethusd_5m_analytics" {
  provider    = google-beta
  dataset_id = google_bigquery_dataset.data_warehouse_analytics.dataset_id
  table_id   = "ethusd_5m"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = var.environment
  }

  external_data_configuration {
    autodetect = true
    source_format = "PARQUET"
    source_uris = [ "gs://${google_project.data-lake.project_id}-storage/analytics/ethusd_5m/*" ]

    hive_partitioning_options {
            mode = "AUTO"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/analytics/ethusd_5m/*"
    }
  }

}

resource "google_bigquery_table" "table_ltcusd_5m_analytics" {
  provider    = google-beta
  dataset_id = google_bigquery_dataset.data_warehouse_analytics.dataset_id
  table_id   = "ltcusd_5m"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = var.environment
  }

  external_data_configuration {
    autodetect = true
    source_format = "PARQUET"
    source_uris = [ "gs://${google_project.data-lake.project_id}-storage/analytics/ltcusd_5m/*" ]

    hive_partitioning_options {
            mode = "AUTO"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/analytics/ltcusd_5m/*"
    }
  }

}

resource "google_bigquery_table" "table_xrpusd_5m_analytics" {
  provider    = google-beta
  dataset_id = google_bigquery_dataset.data_warehouse_analytics.dataset_id
  table_id   = "xrpusd_5m"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = var.environment
  }

  external_data_configuration {
    autodetect = true
    source_format = "PARQUET"
    source_uris = [ "gs://${google_project.data-lake.project_id}-storage/analytics/xrpusd_5m/*" ]

    hive_partitioning_options {
            mode = "AUTO"
            source_uri_prefix = "gs://${google_project.data-lake.project_id}-storage/analytics/xrpusd_5m/*"
    }
  }

}
