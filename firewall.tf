# Firewall rule to allow ICMP traffic (e.g., ping)
# ICMP(ping 등) 트래픽을 허용하는 방화벽 규칙을 생성합니다.
# 소스 범위를 "0.0.0.0/0"으로 설정하여 모든 IP 주소에서의 ICMP 트래픽을 허용합니다.
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

# Firewall rule to allow SSH traffic on TCP port 22
# TCP 포트 22번(SSH) 트래픽을 허용하는 방화벽 규칙을 생성합니다.
# 보안 강화를 위해 소스 IP 범위를 제한하는 것이 좋습니다. (예: 특정 IP 대역)
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-${var.network_id}"
  network = google_compute_network.default.id
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.ssh_source_ranges
  target_tags   = ["allow-ssh"]
}