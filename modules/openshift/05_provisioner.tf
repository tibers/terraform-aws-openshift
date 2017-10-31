module "provisioner" {
  source        = "../asg"
  subnet_ids    = "${var.subnet_ids}"
  environment   = "${var.environment}"
  name          = "${var.provisioner_name}"
  vpc_id        = "${var.vpc_id}"
  instance_type = "${var.provisioner_instance_type}"
  instance_profile = "${aws_iam_instance_profile.provisioner.name}"
  ami               = "${var.provisioner_ami}"
  instance_key_name = "${var.instance_key_name}"
  user_data     = "${data.template_file.provisioner.rendered}"
  target_group_arns =         ["${aws_alb_target_group.master.arn}"]
  management_net    = "${var.management_net}"
}


data "template_file" "provisioner" {
    template = "${file("${var.provisioner_user_data}")}"
    vars {
        provisioner = "${var.environment}_${var.provisioner_name}"
        environment = "${var.environment}"
        master_lb = "${aws_alb.master.dns_name}"
    }
}

resource "local_file" "vagrant" {
    content     = "${data.template_file.provisioner.rendered}"
    filename = "${var.provisioner_user_data_rendered}"
}