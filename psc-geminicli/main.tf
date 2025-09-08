resource "google_project_service" "default" {
  for_each = toset([
    "dns.googleapis.com",
    "aiplatform.googleapis.com",
    "servicedirectory.googleapis.com"
  ])

  service            = each.value
  disable_on_destroy = false
}

resource "google_compute_network" "default" {
  project                 = var.project_id
  name                    = var.network_id
  auto_create_subnetworks = false
  mtu                     = 1460
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "default" {
  name          = "vm1-subnet"
  ip_cidr_range = "192.168.100.0/24"
  region        = "us-east1"
  stack_type    = "IPV4_ONLY"
  network       = google_compute_network.default.id
}

resource "google_compute_firewall" "allow_icmp" {
  name    = "allow-icmp-${google_compute_network.default.name}"
  network = google_compute_network.default.id
  project = var.project_id

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-icmp"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-${google_compute_network.default.name}"
  network = google_compute_network.default.id
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-ssh"]
}