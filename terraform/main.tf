provider "google" {
    version         = "~> 2.5.0"
    project         = var.project_name
    region          = var.region
    credentials     = file("../app/scripts/auth/gcp-auth.json")
}
