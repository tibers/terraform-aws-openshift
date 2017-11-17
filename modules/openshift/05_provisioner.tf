module "provisioner" {
  source           = "../asg"
  subnet_ids       = "${var.subnet_ids}"
  environment      = "${var.environment}"
  name             = "${var.provisioner_name}"
  vpc_id           = "${var.vpc_id}"
  instance_type    = "${var.provisioner_instance_type}"
  instance_profile = "${aws_iam_instance_profile.provisioner.name}"
  ami              = "${var.provisioner_ami}"
  admin_ssh_key    = "${aws_key_pair.admin_key.key_name}"
  load_balancers   = ["${aws_elb.master.name}"]
  user_data        = "${data.template_file.provisioner.rendered}"
  management_net   = "${var.management_net}"
}

data "template_file" "provisioner" {
  template = "${file("${var.provisioner_user_data}")}"

  vars {
    master        = "${replace("${module.master.name}", "-", "_")}"
    environment   = "${var.environment}"
    public_domain = "${var.public_domain}"
    region        = "${data.aws_region.current.name}"
    log_group     = "${var.environment}"
    sqs           = "${aws_sqs_queue.scaling.id}"
    ssm           = "${aws_ssm_document.openshift.name}"
  }
}

data "aws_region" "current" {
  current = true
}

resource "aws_ssm_document" "openshift" {
  name          = "${var.environment}_openshift"
  document_type = "Command"

  content = <<DOC
  {
              "schemaVersion":"2.2",
              "description":"cross-platform sample",
              "mainSteps":[
                  {
                    "action":"aws:runShellScript",
                    "name":"Ansible",
                    "inputs":{
                        "runCommand":[
                          "provisioner.sh"
                        ]
                    }
                  }
              ]
}
DOC
}
