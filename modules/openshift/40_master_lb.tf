resource "aws_elb" "master" {
  internal        = "false"
  subnets         = ["${var.subnet_ids}"]
  security_groups = ["${aws_security_group.default.id}"]

  listener {
    instance_port     = 8443
    instance_protocol = "tcp"
    lb_port           = 8443
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 443
    instance_protocol = "tcp"
    lb_port           = 443
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
