resource "aws_launch_configuration" "alc" {
  image_id      = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.instance_key_name}"
  spot_price    = "0.05"

  user_data = "${var.user_data}"
  iam_instance_profile = "${var.instance_profile}"

  lifecycle {
    create_before_destroy = true
  }
  security_groups             = ["${aws_security_group.default.id}"]
  associate_public_ip_address = "true"
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = "${aws_launch_configuration.alc.name}"
  name                 = "${var.environment}_${var.name}"
  vpc_zone_identifier  = ["${var.subnet_ids}"]
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  desired_capacity     = "${var.desired_capacity}"
  target_group_arns       = ["${var.target_group_arns}"]

  lifecycle {
    create_before_destroy = true
  }
}

