resource "google_cloudbuild_trigger" "gcp-data-lake-analytics-etl" {
  name          = "gcp-data-lake-analytics"
  tags          = ["etl"]
  filename      = "cloudbuild.yaml"

  github {
    dir         = "/app"
    branch_name = "main"
    owner       = "israelmendez232"
    name        = "gcp-data-lake-analytics" 

  }

  pull_request {
      branch    = "main"
  }

  repo_source {
    repo_name   = "gcp-data-lake-analytics"
    dir         = "/app"
  }

  step {
      name      = "gcp-data-lake-analytics-etl"
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
