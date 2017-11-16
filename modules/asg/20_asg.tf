resource "aws_launch_configuration" "alc" {
  image_id      = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.admin_ssh_key}"
  spot_price    = "${var.spot_price}"

  user_data            = "${var.user_data}"
  iam_instance_profile = "${var.instance_profile}"

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    delete_on_termination = true
  }

  security_groups             = ["${aws_security_group.default.id}"]
  associate_public_ip_address = "true"
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = "${aws_launch_configuration.alc.name}"
  vpc_zone_identifier  = ["${var.subnet_ids}"]
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  desired_capacity     = "${var.desired_capacity}"
  load_balancers       = ["${var.load_balancers}"]

  lifecycle {
    create_before_destroy = true
  }

  tags = [
    {
      key                 = "Name"
      value               = "${var.name}"
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = "${var.environment}"
      propagate_at_launch = true
    },
  ]
}
