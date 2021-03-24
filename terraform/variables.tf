locals {
  region = "asia-southeast1"
  unique_id = "cloud-iac"
  billing_id = ""
  environment = "dev"
}


| **Zones** | **File**          | **Partition** | **Source**            |
|-----------|-------------------|---------------|-----------------------|
| Raw       | .json/.csv/others | No            | System of Record      |
| Trusted   | .parquet          | Yes           | Raw                   |
| Analytics | .parquet          | No            | Trusted + Custom Code |
