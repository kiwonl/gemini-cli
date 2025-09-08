# 지정된 서비스 계정에 'Compute Instance Admin (v1)' 역할을 부여
# 이 역할은 VM 인스턴스를 관리하는 데 필요한 권한을 포함합니다.
resource "google_project_iam_member" "instance_admin" {
  project = var.project_id
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${var.service_account_email}"
}

# 지정된 서비스 계정에 'IAP-secured Tunnel User' 역할을 부여
# 이 역할은 외부 IP가 없는 VM에 IAP를 통해 SSH 터널링으로 접근하는 데 필요합니다.
resource "google_project_iam_member" "iap_tunnel_user" {
  project = var.project_id
  role    = "roles/iap.tunnelResourceAccessor"
  member  = "serviceAccount:${var.service_account_email}"
}
