// Master external API endpoint
output "master_endpoint" {
  value = "https://master_${var.environment}.${var.public_domain}:8443"
}

//Public router
output "public_endpoint" {
  value = "https://public.${var.environment}.${var.public_domain}"
}
