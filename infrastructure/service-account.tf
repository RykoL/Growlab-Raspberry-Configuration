resource "google_service_account" "image_upload" {
  account_id   = "image-upload-account"
  display_name = "Image upload service account"
}

resource "google_storage_bucket_iam_binding" "binding" {
  bucket = google_storage_bucket.images.name
  role = "roles/storage.admin"
  members = [
    "serviceAccount:${google_service_account.image_upload.email}"
  ]
}
