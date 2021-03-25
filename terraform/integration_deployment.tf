resource "google_cloudbuild_trigger" "filename-trigger" {
  name = "gcp-data-lake-analytics"
  tags = ["etl"]
  filename = "cloudbuild.yaml"

  github {
    name   = "gcp-data-lake-analytics"
    dir = "/app"
    branch_name = "main"
  }

  pull_request {
      branch = "main"
  }

  repo_source {
    repo_name = "gcp-data-lake-analytics"
    dir = "/app"
  }

  step {
      name = "gcp-data-lake-analytics-etl"
  }

  options {
      env = [
            "GOOGLE_APPLICATION_CREDENTIALS=/scripts/auth/gcp-auth.json"
            , "url_api=https://api-pub.bitfinex.com/v2"
            , "timeframe=5m"
            , "bucket_name=data-lake-israel-mendes"
            , "limit=10000"
            , "KUBECONFIG=application.yaml"
      ]
  }
}
