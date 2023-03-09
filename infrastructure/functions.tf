data "archive_file" "image_upload_api_source" {
  type = "zip"
  output_path = "image-upload-api.zip"
  source_dir = "../api"
}

resource "google_storage_bucket_object" "image_upload_api_source" {
  name = "image-upload-api.zip"
  bucket = google_storage_bucket.api_source_bucket.name
  source = data.archive_file.image_upload_api_source.output_path
}

resource "google_cloudfunctions_function" "image-upload" {
  name = "image-upload"
  runtime = "go119"
  region = "europe-west1"
  entry_point = "HelloWorld"

  source_archive_bucket = google_storage_bucket.api_source_bucket.name
  source_archive_object = google_storage_bucket_object.image_upload_api_source.name

  trigger_http = true
}
