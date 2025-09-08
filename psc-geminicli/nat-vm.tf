resource "google_compute_router" "default" {
  name    = "outbound-nat"
  region  = "us-east1"
  network = google_compute_network.default.id

 bgp {
  asn = 64514
  }
}

resource "google_compute_router_nat" "default" {
  name                               = "outbound-gw"
  router                             = google_compute_router.default.name
  region                             = google_compute_router.default.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_instance" "vm1" {
  name         = "cli-vm"
  zone         = "us-east1-b"
  machine_type = "n2-standard-2"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.default.id  
    stack_type = "IPV4_ONLY"
  }

  tags = ["allow-ssh", "allow-icmp"]

  metadata_startup_script = <<-EOF
    sudo apt-get update    
  EOF
}

resource "google_compute_instance" "vm2" {
  name         = "monitor-vm"
  zone         = "us-east1-b"
  machine_type = "n2-standard-2"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.default.id   
    stack_type = "IPV4_ONLY"
  }

  tags = ["allow-ssh", "allow-icmp"]

  metadata_startup_script = <<-EOF
    sudo apt-get update
    sudo apt-get install python3 python3-dev python3-venv -y
    sudo apt-get install tcpdump dnsutils -y
  EOF
}