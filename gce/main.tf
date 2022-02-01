resource "google_compute_instance" "vm-fortify-controller" {
  name = "vm-fortify-controller"
  zone = "us-west1-a"
  machine_type = "n1-standard-2"

  allow_stopping_for_update = true

  network_interface {
    network = "fortify-custom"
    subnetwork = "fortify-sub"
  }

  boot_disk {
    initialize_params {
      image = "rhel-8-v20210217"
      size = 20
    }
    auto_delete = true
  }

  labels = {
    "depto" = "cyber"
    "env" = "dev"
  }
  scheduling {
    preemptible = true
    automatic_restart = false
  }

  lifecycle {
    ignore_changes = [attached_disk]
  }

}

resource "google_compute_disk" "disk-1" {
  name = "disk-1"
  size = 15
  zone = "us-west1-a"
  type = "pd-ssd"
}

resource "google_compute_attached_disk" "adisk" {
  disk = google_compute_disk.disk-1.id
  instance = google_compute_instance.vm-fortify-controller.id
}
