resource "google_storage_bucket" "gcs_bucket" {
  name     = "lf258-tf-state"
  location = var.region
}

resource "google_compute_network" "vpc_network" {
  name                    = "lfclass"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "lfclass" {
  name          = "lfclass"
  ip_cidr_range = "10.0.0.0/24"
  network       = google_compute_network.vpc_network.name
}

resource "google_compute_firewall" "default" {
  name    = "lfclass"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "all"
  }
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_project_metadata_item" "default" {
  key     = "ssh-keys"
  value   = "${var.ssh_user.name}:${var.ssh_user.public_key}"
  project = var.project_id
}

# Create a single Compute Engine instance
resource "google_compute_instance" "default" {
  name         = "cp"
  machine_type = "e2-standard-2"
  tags         = ["ssh"]

  metadata = {
    enable-oslogin = "TRUE"
  }
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = 20
    }
  }

  network_interface {
    subnetwork = "lfclass"
    access_config {
      # Include this section to give the VM an external IP address
    }
  }

  depends_on = [
    google_compute_subnetwork.lfclass
  ]
}

resource "google_compute_instance" "worker" {
  name         = "worker"
  machine_type = "e2-standard-2"
  tags         = ["ssh"]

  metadata = {
    enable-oslogin = "TRUE"
  }
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = 20
    }
  }

  network_interface {
    subnetwork = "lfclass"
    access_config {
      # Include this section to give the VM an external IP address
    }
  }

  depends_on = [
    google_compute_subnetwork.lfclass
  ]
}
