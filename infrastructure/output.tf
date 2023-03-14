output "load_balancer_ip" {
  value = module.gce-lb-http.external_ip
}
