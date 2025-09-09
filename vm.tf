# 'cli-vm'이라는 이름의 Compute Engine VM 인스턴스를 생성합니다.
# 이 VM은 외부 IP 주소 없이 생성되며, IAP 터널링을 통해 접근해야 합니다.
resource "google_compute_instance" "vm1" {
  project      = var.project_id
  name         = var.vm_name
  zone         = "${var.region}-c"
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  # No external IP
  network_interface {
    subnetwork = google_compute_subnetwork.default.id
  }

  # 방화벽 규칙을 적용하기 위한 태그를 설정합니다.
  tags = ["allow-ssh", "allow-icmp"]

  # Startup script to update package lists on boot
  # VM 시작 시 실행될 스크립트로, 패키지 목록을 업데이트합니다.
  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
  EOF
}
