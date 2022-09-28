resource "google_compute_network" "vpc_network" {
  name = "lfclass"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "lfclass" {
  name = "lfclass"
  ip_cidr_range = "10.0.0.0/24"
  network = google_compute_network.vpc_network.name
}

resource "google_compute_firewall" "default" {
  name = "lfclass"
  network = google_compute_network.vpc_network.name
  
  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0"]
}

# Create a single Compute Engine instance
resource "google_compute_instance" "default" {
  name         = "cp"
  machine_type = "e2-standard-2"
  zone         = "europe-north1-a"
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

  # Install Flask
  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq install curl apt-transport-https vim git wget gnupg2 software-properties-common apt-transport-https ca-certificates uidmap"

  network_interface {
    subnetwork = "lfclass"
    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}

resource "google_compute_instance" "worker" {
  name         = "worker"
  machine_type = "e2-standard-2"
  zone         = "europe-north1-a"
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

  # Install Flask
  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

  network_interface {
    subnetwork = "lfclass"
    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}
