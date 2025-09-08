resource "google_compute_global_address" "default" {
  name         = "gemini-ip"
  purpose      = "PRIVATE_SERVICE_CONNECT"
  network      = google_compute_network.default.id
  address_type = "INTERNAL"
  address      = "10.10.100.250"
}

resource "google_compute_global_forwarding_rule" "default" {  
  name                  = "pscgemini"
  target                = "all-apis"
  network               = google_compute_network.default.id
  ip_address            = google_compute_global_address.default.id
  load_balancing_scheme = ""
  }