// Master external API endpoint
output "master_public_endpoint" {
  value = "https://public.${var.environment}.${var.public_domain}:8443"
}
