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
