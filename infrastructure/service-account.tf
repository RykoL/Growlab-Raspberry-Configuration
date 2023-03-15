resource "google_service_account" "image_upload" {
  account_id   = "image-upload-account"
  display_name = "Image upload service account"
}

# data "google_iam_policy" "admin" {
#   binding {
#     role = "roles/storage.admin"
#     members = [
#       "serviceAccount:${google_service_account.image_upload.email}"
#     ]
#   }
# }

# resource "google_storage_bucket_iam_policy" "policy" {
#   bucket = google_storage_bucket.images.name
#   policy_data = data.google_iam_policy.admin.policy_data
# }

resource "google_storage_bucket_iam_binding" "binding" {
  bucket = google_storage_bucket.images.name
  role = "roles/storage.admin"
  members = [
    "serviceAccount:${google_service_account.image_upload.email}"
  ]
}
