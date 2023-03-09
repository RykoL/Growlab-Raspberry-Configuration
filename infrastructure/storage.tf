resource "google_storage_bucket" "api_source_bucket" {
  name = "api-source-bucket"
  location = "us-east1"
}
