resource "aws_alb" "master" {
  name            = "master"
  internal        = false
  security_groups = ["${module.provisioner.sg_id}"]
  subnets         = ["${var.subnet_ids}"]

  tags {
    Environment = "${var.environment}-master"
  }
}

resource "aws_alb_target_group" "master" {
  name     = "master"
  port     = 8443
  protocol = "HTTPS"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_alb_listener" "master" {
  load_balancer_arn = "${aws_alb.master.arn}"
  port              = "80"
  protocol          = "HTTP"
  //ssl_policy        = "ELBSecurityPolicy-2015-05"
  //certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    target_group_arn = "${aws_alb_target_group.master.arn}"
    type             = "forward"
  }
}