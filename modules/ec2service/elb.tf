resource "aws_elb" "elb" {
  name = "${var.name}"

  internal                  = "${var.internal}"
  cross_zone_load_balancing = true
  subnets                   = ["${var.subnet_ids}"]
  security_groups           = ["${var.security_groups}"]

  idle_timeout                = 30
  connection_draining         = true
  connection_draining_timeout = 15

  listener {
    lb_port           = "${var.lb_port}"
    lb_protocol       = "${var.protocol}"
    instance_port     = "${var.instance_port}"
    instance_protocol = "${var.protocol}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "${var.protocol}:${var.instance_port}${var.healthcheck}"
    interval            = 30
  }

  tags {
    Name        = "${var.name}-balancer"
    Service     = "${var.name}"
    Environment = "${var.environment}"
  }
}
