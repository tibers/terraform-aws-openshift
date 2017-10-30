module "securitygroup" {
  source      = "../service_sgs"
  environment = "${var.environment}"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "allow_ingress_ssh_from_all" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${element(module.securitygroup.aws_security_group_ids, count.index)}"
}
