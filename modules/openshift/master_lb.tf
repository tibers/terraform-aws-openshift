resource "aws_elb" "master" {
  internal        = "false"
  subnets         = ["${var.public_subnet_ids}"]
  security_groups = ["${module.master.sg}"]

  listener {
    instance_port     = 8443
    instance_protocol = "tcp"
    lb_port           = 8443
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8443"
    interval            = 30
  }

  cross_zone_load_balancing = true

  tags {
    Name = "${var.environment}-master"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "internal_master" {
  internal        = "true"
  subnets         = ["${var.private_subnet_ids}"]
  security_groups = ["${module.master.sg}"]

  listener {
    instance_port     = 8443
    instance_protocol = "tcp"
    lb_port           = 8443
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8443"
    interval            = 30
  }

  cross_zone_load_balancing = true

  tags {
    Name = "${var.environment}-internal_master"
  }

  lifecycle {
    create_before_destroy = true
  }
}
