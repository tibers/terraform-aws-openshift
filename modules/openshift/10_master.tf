module "master" {
  source            = "../asg"
  subnet_ids        = "${var.subnet_ids}"
  environment       = "${var.environment}"
  name              = "${var.master_name}"
  vpc_id            = "${var.vpc_id}"
  instance_type     = "${var.master_instance_type}"
  instance_profile  = "${aws_iam_instance_profile.master.name}"
  ami               = "${var.master_ami}"
  instance_key_name = "${var.instance_key_name}"
  user_data         = "${data.template_file.master.rendered}"
  load_balancers    = ["${aws_elb.master.name}"]
  management_net    = "${var.management_net}"
  security_groups   = ["${aws_security_group.default.id}"]
}

data "template_file" "master" {
  template = "${file("${var.master_user_data}")}"

  vars {
    environment = "${var.environment}"
    region        = "${data.aws_region.current.name}"
  }
}
