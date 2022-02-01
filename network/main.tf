resource "google_compute_network" "fortify-custom" {
  name = "fortify-custom"
  auto_create_subnetworks = false
}

  output "custom" {
      value = google_compute_network.fortify-custom.id
  }

resource "google_compute_subnetwork" "fortify-sub" {
    name = "fortify-sub"
    description = "Main subnet for Fortify"
    network = google_compute_network.fortify-custom.id
    ip_cidr_range = "192.168.0.0/25"
    region = "us-west1"
    private_ip_google_access = true
}

resource "google_compute_firewall" "allow-icmp" {
  name = "allow-icmp"
  network = google_compute_network.fortify-custom.id
  allow {
    protocol = "icmp"
  }
  source_ranges = ["189.19.116.13/32"]
  priority = 455
}

resource "google_compute_firewall" "allow-tcp" {
  name = "allow-tcp"
  network = google_compute_network.fortify-custom.id
  allow {
    protocol = "tcp"
    ports = [ "80", "443", "22" ]
  }
  source_ranges = ["189.19.116.13/32"]
  priority = 455
}