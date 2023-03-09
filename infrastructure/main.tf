provider "google" {
  project = "grow-lab-stuttgart-f971"
}

resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "default" {
  name          = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  force_destroy = false
  location      = "us-east1"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

terraform {
 backend "gcs" {
   bucket  = "800024d185b3f036-bucket-tfstate"
   prefix  = "terraform/state"
 }
}
