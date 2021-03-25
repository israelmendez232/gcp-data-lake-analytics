variable "region" {
  description = "Region for the GCP services."
  type        = string
  default     = "europe-west3" # DEV Env
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

variable "email_admin" {
  description = "Email for 'admin' role, on BigQuery and others services."
  type        = string
}

variable "email_advanced" {
  description = "Email for 'advanced' role, on BigQuery."
  type        = string
}

variable "email_essencial" {
  description = "Email for 'essencial' role, on BigQuery."
  type        = string
}

variable "project_name" {
  description = "Name of the project."
  type        = string
}
