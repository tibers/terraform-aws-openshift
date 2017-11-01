// Master external API endpoint
output "openshift_public_hostname" {
  value = "https://public.${var.environment}.${var.public_domain}:8443"
}
