variable "region" {
  description = "Region for the GCP services."
  type        = string
  default     = "asia-southeast1" # DEV Env
}

variable "billing_id" {
  description = "ID to bill the services."
  type        = string
}

variable "environment" {
  description = "The type of environment using, such as being staged (dev) or in production."
  type        = string
  default     = "dev" # DEV Env
}

variable "email" {
  description = "Email of the respectible owner of the services."
  type        = string
}
