variable "project" {
  default = "nohup-364111"
}

variable "ssh_user" {
  default = {
    name            = "ubuntu"
    public_key_path = "~/.ssh/id_rsa.pub"
  }
}
