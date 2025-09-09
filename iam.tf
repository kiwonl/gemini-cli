# Grant the 'Compute Instance Admin (v1)' role to the default service account
# 지정된 서비스 계정에 'Compute Instance Admin (v1)' 역할을 부여합니다.
# 이 역할은 VM 인스턴스 생성, 삭제, 시작, 중지 등 인스턴스 관리에 필요한 모든 권한을 포함합니다.
resource "google_project_iam_member" "instance_admin" {
  project = var.project_id
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${var.project_id}@${var.project_id}.iam.gserviceaccount.com"
}

# Grant the 'IAP-secured Tunnel User' role to the default service account
# 지정된 서비스 계정에 'IAP-secured Tunnel User' 역할을 부여합니다.
# 이 역할은 외부 IP 주소가 없는 VM 인스턴스에 IAP(Identity-Aware Proxy)를 통해
# SSH 터널링으로 안전하게 접근하는 데 필요합니다.
resource "google_project_iam_member" "iap_tunnel_user" {
  project = var.project_id
  role    = "roles/iap.tunnelResourceAccessor"
  member  = "serviceAccount:${var.project_id}@${var.project_id}.iam.gserviceaccount.com"
}