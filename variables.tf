variable "project_id" {
  type        = string
  description = "The GCP Id"
}

variable "region" {
  type    = string
  default = "europe-north1"
}

variable "ssh_user" {
  type = object({
    name           = string
    public_key     = string
  })
}
