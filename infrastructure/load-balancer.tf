module "gce-lb-http" {
  source  = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version = "~> 6.3"

  project = var.project_id
  name    = "growlab-ingress-load-balancer"
  backends = {
    default = {
      description             = null
      port_name               = null
      timeout_sec             = 10
      enable_cdn              = false
      custom_request_headers  = null
      custom_response_headers = null
      security_policy         = google_compute_security_policy.ingress_policy.id

      log_config = {
        enable      = false
        sample_rate = null
      }

      groups = [
        {
          group = google_compute_region_network_endpoint_group.serverless_neg.id
        }
      ]

      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    }
  }
}

resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  name                  = "serverless-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.default_region
  cloud_function {
    function = google_cloudfunctions_function.image_upload.name
  }
}


resource "google_compute_security_policy" "ingress_policy" {
  name = "global-load-balancer-ingress"

  rule {
    action   = "allow"
    priority = "1000"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = [
          "${var.raspberry_public_ip}/${var.raspberry_public_cidr}",
          "217.111.124.227/32"
        ]
      }
    }
    description = "Allows access from raspberyy public ip"
  }

  rule {
    action   = "deny(403)"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }
}
