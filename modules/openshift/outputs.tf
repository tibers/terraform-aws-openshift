// Master external API endpoint
output "public_master_endpoint" {
  value = "https://${aws_route53_record.master.fqdn}:8443"
}

output "private_master_endpoint" {
  value = "https://${aws_route53_record.internal_master.fqdn}:8443"
}

//Public router
output "public_endpoint" {
  value = "https://public.${var.environment}.${var.public_domain}"
}
