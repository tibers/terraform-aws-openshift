resource "aws_security_group_rule" "allow_ssh_from_provisioner_to_masters" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${module.provisioner.sg}"
  security_group_id        = "${module.master.sg}"
}

resource "aws_security_group_rule" "allow_ssh_from_provisioner_to_infra_nodes" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${module.provisioner.sg}"
  security_group_id        = "${module.infra.sg}"
}

//Temp
resource "aws_security_group_rule" "allow_all_from_masters_to_infra_nodes" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = "${module.master.sg}"
  security_group_id        = "${module.infra.sg}"
}

//Temp
resource "aws_security_group_rule" "allow_all_from_infra_nodes_to_masters" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = "${module.infra.sg}"
  security_group_id        = "${module.master.sg}"
}

resource "aws_security_group_rule" "allow_ssh_from_provisioner_to_app_nodes" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${module.provisioner.sg}"
  security_group_id        = "${module.app.sg}"
}

//Temp
resource "aws_security_group_rule" "allow_all_from_masters_to_app_nodes" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = "${module.master.sg}"
  security_group_id        = "${module.app.sg}"
}

//Temp
resource "aws_security_group_rule" "allow_all_from_app_nodes_to_masters" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = "${module.app.sg}"
  security_group_id        = "${module.master.sg}"
}

//Temp
resource "aws_security_group_rule" "allow_all_from_app_nodes_to_infra_nodes" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = "${module.app.sg}"
  security_group_id        = "${module.infra.sg}"
}

//Temp
resource "aws_security_group_rule" "allow_all_from_infra_nodes_to_app_nodes" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = "${module.infra.sg}"
  security_group_id        = "${module.app.sg}"
}
