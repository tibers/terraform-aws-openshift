resource "aws_security_group" "default" {
  description = "${var.environment}"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name = "${var.environment}"
  }
  
  lifecycle {
      create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.default.id}"
}

resource "aws_security_group_rule" "allow_ingress_self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.default.id}"
}

resource "aws_security_group_rule" "allow_ingress_ssh_from_all" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["${var.management_net}"]
  security_group_id = "${aws_security_group.default.id}"
}
