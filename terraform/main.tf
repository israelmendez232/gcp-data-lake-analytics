provider "google" {
    project         = var.project_name
    region          = var.region
    credentials     = file("../app/scripts/auth/gcp-auth.json")
}

provider "google-beta" {
    project         = var.project_name
    region          = var.region
    credentials     = file("../app/scripts/auth/gcp-auth.json")
}
