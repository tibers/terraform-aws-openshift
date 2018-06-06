locals {
  # Some DNS that we will set up
  dns_public_router   = "*.public.${var.environment}.${data.aws_route53_zone.selected.name}"
  dns_master          = "${var.environment}.${data.aws_route53_zone.selected.name}"
  dns_master_internal = "${var.environment}_internal.${data.aws_route53_zone.selected.name}"

  # List of SAN that we wish to set on the ACM cert
  acm_san = [
    "${substr(local.dns_public_router, 0, length(local.dns_public_router) - 1)}",
  ]
}
