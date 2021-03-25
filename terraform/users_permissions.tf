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

# TODO: see if it's better bellow then by data_warehouse.tf
# resource "google_bigquery_dataset_iam_policy" "dataset_admin" {
#   dataset_id  = "raw"
#   policy_data = data.google_iam_policy.owner.policy_data
# }

# resource "google_bigquery_dataset_iam_policy" "dataset_advanced" {
#   dataset_id  = "trusted"
#   policy_data = data.google_iam_policy.advanced.policy_data
# }

# resource "google_bigquery_dataset_iam_policy" "dataset_essencial" {
#   dataset_id  = "analytics"
#   policy_data = data.google_iam_policy.essencial.policy_data
# }
