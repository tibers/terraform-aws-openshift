data "aws_subnet" "selected" {
  id = "${var.subnet_ids[0]}"
}

module "securitygroup" {
  count  = "${var.own_security_group == "true" ? 1 : 0}"
  source          = "../securitygroup"
  environment     = "${var.environment}"
  vpc_id          = "${data.aws_subnet.selected.vpc_id}"
}
