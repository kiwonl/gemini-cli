# for_each를 사용하여 지정된 Google Cloud API 목록을 프로젝트에서 활성화합니다.
resource "google_project_service" "default" {
  for_each = toset([
    "dns.googleapis.com",
    "aiplatform.googleapis.com",
    "servicedirectory.googleapis.com"
  ])

  service            = each.value
  disable_on_destroy = false
}