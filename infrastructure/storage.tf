resource "google_storage_bucket" "api_source_bucket" {
  name     = "api-source-bucket"
  location = "us-east1"
}

resource "google_storage_bucket" "images" {
  name     = "${random_id.bucket_prefix.hex}-plant-images"
  location = "us-east1"
}
