data "google_iam_policy" "admin" {
  binding {
    role = "roles/dataOwner"

    members = [
      "user:${var.email_admin}",
    ]
  }
}

data "google_iam_policy" "advanced" {
  binding {
    role = "roles/bigquery.dataEditor"

    members = [
        "user:${var.email_advanced}",
    ]
  }
}

data "google_iam_policy" "essencial" {
  binding {
    role = "roles/bigquery.dataViewer"

    members = [
      "user:${var.email_essencial}",
    ]
  }
}


# ACCESS FOR THE DATASETS
resource "google_bigquery_dataset_iam_policy" "data_warehouse_raw_access_admin" {
  provider    = google-beta
  dataset_id  = google_bigquery_dataset.data_warehouse_raw.dataset_id
  policy_data = data.google_iam_policy.admin.policy_data
}
resource "google_bigquery_dataset_iam_policy" "data_warehouse_trusted_access_admin" {
  provider    = google-beta
  dataset_id  = google_bigquery_dataset.data_warehouse_trusted.dataset_id
  policy_data = data.google_iam_policy.admin.policy_data
}
resource "google_bigquery_dataset_iam_policy" "data_warehouse_trusted_access_advanced" {
  provider    = google-beta
  dataset_id  = google_bigquery_dataset.data_warehouse_trusted.dataset_id
  policy_data = data.google_iam_policy.advanced.policy_data
}
resource "google_bigquery_dataset_iam_policy" "data_warehouse_analytics_access_admin" {
  provider    = google-beta
  dataset_id  = google_bigquery_dataset.data_warehouse_analytics.dataset_id
  policy_data = data.google_iam_policy.admin.policy_data
}
resource "google_bigquery_dataset_iam_policy" "data_warehouse_analytics_access_advanced" {
  provider    = google-beta
  dataset_id  = google_bigquery_dataset.data_warehouse_analytics.dataset_id
  policy_data = data.google_iam_policy.advanced.policy_data
}
resource "google_bigquery_dataset_iam_policy" "data_warehouse_analytics_access_essencial" {
  provider    = google-beta
  dataset_id  = google_bigquery_dataset.data_warehouse_analytics.dataset_id
  policy_data = data.google_iam_policy.essencial.policy_data
}
