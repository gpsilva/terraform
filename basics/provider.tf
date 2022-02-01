terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.8.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "calm-premise-168420"
  region = "us-west1"
  zone = "us-west1-a"
}
