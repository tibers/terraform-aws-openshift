resource "aws_elb" "infra" {
  internal        = "false"
  subnets         = ["${var.public_subnet_ids}"]
  security_groups = ["${module.infra.sg}"]

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
    target              = "TCP:443"
    interval            = 30
  }

  cross_zone_load_balancing = true

  tags {
    Name = "${var.environment}-infra"
  }

  lifecycle {
    create_before_destroy = true
  }
}
