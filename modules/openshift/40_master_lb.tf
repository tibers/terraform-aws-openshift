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

  default_action {
    target_group_arn = "${aws_alb_target_group.master.arn}"
    type             = "forward"
  }
}