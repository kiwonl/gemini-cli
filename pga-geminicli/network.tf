# 커스텀 모드 VPC(Virtual Private Cloud) 네트워크를 생성합니다.
resource "google_compute_network" "default" {
  project                 = var.project_id
  name                    = var.network_id
  auto_create_subnetworks = false
  mtu                     = 1460
  routing_mode            = "GLOBAL"
}

# 위에서 생성한 VPC 네트워크 내에 서브넷을 생성합니다.
resource "google_compute_subnetwork" "default" {
  name                      = "vm1-subnet"
  ip_cidr_range             = "192.168.100.0/24"
  region                    = "us-east1"
  stack_type                = "IPV4_ONLY"
  network                   = google_compute_network.default.id
  # Private Google Access 활성화
  private_ip_google_access  = true
}

# 동적 라우팅 및 Cloud NAT의 제어부 역할을 하는 Cloud Router를 생성합니다.
resource "google_compute_router" "default" {
  name    = "outbound-nat"
  region  = "us-east1"
  network = google_compute_network.default.id

 bgp {
  asn = 64514
  }
}

# 외부 IP 주소가 없는 VM 인스턴스가 인터넷에 액세스할 수 있도록 Cloud NAT 게이트웨이를 생성합니다.
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