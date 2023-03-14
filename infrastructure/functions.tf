data "archive_file" "image_upload_api_source" {
  type        = "zip"
  output_path = "image-upload-api.zip"
  source_dir  = "../api"
}

resource "google_storage_bucket_object" "image_upload_api_source" {
  name   = "image-upload-api.zip"
  bucket = google_storage_bucket.api_source_bucket.name
  source = data.archive_file.image_upload_api_source.output_path
}

resource "google_cloudfunctions_function" "image_upload" {
  name        = "image-upload"
  runtime     = "go119"
  region      = "europe-west1"
  entry_point = "UploadImageHandler"

  source_archive_bucket = google_storage_bucket.api_source_bucket.name
  source_archive_object = google_storage_bucket_object.image_upload_api_source.name

  trigger_http = true
  ingress_settings = "ALLOW_INTERNAL_AND_GCLB"
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.image_upload.project
  region         = google_cloudfunctions_function.image_upload.region
  cloud_function = google_cloudfunctions_function.image_upload.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
