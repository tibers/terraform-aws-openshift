resource "aws_security_group" "terralib" {
  name = "${var.name}"
  description = "${var.name} is the Terralib generated Security Group"
  vpc_id = "${var.vpc_id}"
  tags {
      Name        = "${var.name} - Security Group"
      Service     = "${var.name}"
      Environment = "${var.environment}"
  }
}

resource "aws_security_group_rule" "allow_egress_internet" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.terralib.id}"
}

resource "aws_security_group_rule" "allow_ingress_self" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  self = true
  security_group_id = "${aws_security_group.terralib.id}"
}