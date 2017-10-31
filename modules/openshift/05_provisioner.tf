module "provisioner" {
  source            = "../asg"
  subnet_ids        = "${var.subnet_ids}"
  environment       = "${var.environment}"
  name              = "${var.provisioner_name}"
  vpc_id            = "${var.vpc_id}"
  instance_type     = "${var.provisioner_instance_type}"
  instance_profile  = "${aws_iam_instance_profile.provisioner.name}"
  ami               = "${var.provisioner_ami}"
  instance_key_name = "${var.instance_key_name}"
  user_data         = "${data.template_file.provisioner.rendered}"
  load_balancers    = ["${aws_elb.master.name}"]
  management_net    = "${var.management_net}"
  security_groups   = ["${aws_security_group.default.id}"]
}

data "template_file" "provisioner" {
  template = "${file("${var.provisioner_user_data}")}"

  vars {
    provisioner = "${var.environment}_${var.provisioner_name}"
    environment = "${var.environment}"
    master_lb   = "${aws_elb.master.dns_name}"

    //public_domain = "${data.aws_route53_zone.selected.name}"
    public_domain = "${var.public_domain}"
  }
}

resource "local_file" "vagrant" {
  content  = "${data.template_file.provisioner.rendered}"
  filename = "${var.provisioner_user_data_rendered}"
}
