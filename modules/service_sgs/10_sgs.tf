resource "aws_security_group" "terralib" {
  count         = "${var.count}"
  name = "${var.name}-${format("%03d", count.index+1)}"
  description = "${var.name} is the Terralib generated Security Group"
  vpc_id = "${var.vpc_id}"
  tags {
      Name        = "${var.name} - Security Group"
      Service     = "${var.name}"
      Environment = "${var.environment}"
  }
}

resource "aws_security_group_rule" "allow_egress_internet" {
  count         = "${var.count}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${element(aws_security_group.terralib.*.id, count.index)}"
}

resource "aws_security_group_rule" "allow_ingress_self" {
  count         = "${var.count}"
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  self = true
  security_group_id = "${element(aws_security_group.terralib.*.id, count.index)}"
}
