resource "google_dns_managed_zone" "private_zone" {
  name        = "googleapis-private"
  dns_name    = "googleapis.com."  
  visibility  = "private"
  project     = var.project_id     

  private_visibility_config {
    networks {
      network_url = google_compute_network.default.id  
    }
  }
}

resource "google_dns_record_set" "a_record" {
  name    = "googleapis.com."  
  type    = "A"
  ttl     = 300
  managed_zone = google_dns_managed_zone.private_zone.name
  project = var.project_id    

  rrdatas = ["10.10.100.250"]
}

resource "google_dns_record_set" "cname_record" {
 name    = "*.googleapis.com."
 type    = "CNAME"
 ttl     = 300
 managed_zone = google_dns_managed_zone.private_zone.name
 project = var.project_id    

 rrdatas = ["googleapis.com."]  
}