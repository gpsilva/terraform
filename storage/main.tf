resource "google_storage_bucket" "fortify-eva" {
  name = "fortify-eva"
  storage_class = "STANDARD"
  location = "US-WEST1"
}

labels = {
    "env" = "fortify_env"
    "dep" = "cybersecurity"
}

uniform_bucket_level_access = true

    lifecycle_rule {
        condition {
            age = 5
        }
        action {
            type = "SetStorageClass"
            storage_class = "COLDLINE"
        }
    }
