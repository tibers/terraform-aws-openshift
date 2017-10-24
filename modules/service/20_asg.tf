resource "aws_launch_configuration" "alc" {
  image_id      = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.instance_key_name}"
  spot_price    = "0.05"
  iam_instance_profile = "${aws_iam_instance_profile.provisioner.name}"

  user_data = "${data.template_file.configurator.rendered}"
  iam_instance_profile = "${var.instance_profile}"

  lifecycle {
    create_before_destroy = true
  }
  security_groups             = ["${element(module.securitygroup.aws_security_group_ids, 0)}"]
  associate_public_ip_address = "true"
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = "${aws_launch_configuration.alc.name}"
  name                 = "${var.environment}_${var.name}"
  vpc_zone_identifier  = ["${var.subnet_ids}"]
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  desired_capacity     = "${var.desired_capacity}"
  //load_balancers       = ["${aws_elb.elb.name}"]

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "configurator" {
    template = "${file("${var.user_data}")}"
    vars {
    master_asg_name = "${var.environment}_${var.name}"
  }
}

resource "local_file" "foo" {
    content     = "${data.template_file.configurator.rendered}"
    filename = "${var.user_data_rendered}"
}