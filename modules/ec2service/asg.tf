resource "aws_launch_configuration" "alc" {
  name_prefix   = "${var.name}"
  image_id      = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.instance_key_name}"
  //user_data = "${file("${var.user_data}")}"
  //iam_instance_profile = "${var.instance_profile}"
  lifecycle {
    create_before_destroy = true
  }
  security_groups = ["${var.security_groups}"]
  associate_public_ip_address = "true"
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = "${aws_launch_configuration.alc.name}"
  vpc_zone_identifier  = ["${var.subnet_ids}"]
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  desired_capacity     = "${var.desired_capacity}"
  load_balancers      = ["${aws_elb.elb.name}"]

  lifecycle {
    create_before_destroy = true
  }

}
