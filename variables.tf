variable "project_id" {
  type        = string
  description = "The GCP Id"
}

variable "region" {
  type    = string
  default = "europe-north1"
}

variable "ssh_user" {
  default = {
    name            = "ubuntu"
    public_key_path = "~/.ssh/id_rsa.pub"
  }
}
