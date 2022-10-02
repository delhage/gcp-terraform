provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "lf258-tf-state"
    prefix = "terraform/state"
  }
}
