# ICMP(ping 등) 트래픽을 허용하는 방화벽 규칙을 생성합니다.
resource "google_compute_firewall" "allow_icmp" {
  name    = "allow-icmp-${var.network_id}"
  network = google_compute_network.default.id
  project = var.project_id

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-icmp"]
}

# TCP 포트 22번(SSH) 트래픽을 허용하는 방화벽 규칙을 생성합니다.
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-${var.network_id}"
  network = google_compute_network.default.id
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-ssh"]
}
