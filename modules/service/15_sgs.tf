module "securitygroup" {
  source      = "github.com/odzhu/terralib/modules/service_sgs"
  environment = "${var.environment}"
  vpc_id      = "${var.vpc_id}"
}