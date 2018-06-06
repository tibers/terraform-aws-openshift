#--------------------------------------------------------------------------------
# Set up ACM certificate for our ALB / ELB
#--------------------------------------------------------------------------------
resource aws_acm_certificate public_cert {
  domain_name = "${substr(local.dns_master, 0, length(local.dns_master) - 1)}"

  subject_alternative_names = [
    "${local.acm_san}",
  ]

  validation_method = "DNS"

  tags {
    Name        = "Openshift certificate ${var.environment}"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}

# Validate the cert
resource aws_route53_record public_cert_validation {
  count   = "${1 + length(local.acm_san)}"                                                                              # the 1 + is for the main domain
  name    = "${lookup(aws_acm_certificate.public_cert.domain_validation_options[count.index], "resource_record_name")}"
  type    = "${lookup(aws_acm_certificate.public_cert.domain_validation_options[count.index], "resource_record_type")}"
  zone_id = "${data.aws_route53_zone.selected.zone_id}"

  records = [
    "${lookup(aws_acm_certificate.public_cert.domain_validation_options[count.index], "resource_record_value")}",
  ]

  ttl = 60
}
