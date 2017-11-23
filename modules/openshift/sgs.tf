// Provisioner ssh access
resource "aws_security_group_rule" "allow_ssh_from_provisioner_to_cluster" {
  count                    = 3
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${module.provisioner.sg}"
  security_group_id        = "${element(list(module.app.sg,module.infra.sg,module.master.sg), count.index)}"
}

//<Enable overlay networking for the cluster

resource "aws_security_group_rule" "allowed_ovs_port_from_cluster_to_master" {
  count                    = 3
  type                     = "ingress"
  from_port                = "${var.allowed_ovs_port_inside_cluster}"
  to_port                  = "${var.allowed_ovs_port_inside_cluster}"
  protocol                 = "udp"
  source_security_group_id = "${element(list(module.app.sg,module.infra.sg,module.master.sg), count.index)}"
  security_group_id        = "${module.master.sg}"
}

resource "aws_security_group_rule" "allowed_ovs_port_from_cluster_to_app" {
  count                    = 3
  type                     = "ingress"
  from_port                = "${var.allowed_ovs_port_inside_cluster}"
  to_port                  = "${var.allowed_ovs_port_inside_cluster}"
  protocol                 = "udp"
  source_security_group_id = "${element(list(module.app.sg,module.infra.sg,module.master.sg), count.index)}"
  security_group_id        = "${module.app.sg}"
}

resource "aws_security_group_rule" "allowed_ovs_port_from_cluster_to_infra" {
  count                    = 3
  type                     = "ingress"
  from_port                = "${var.allowed_ovs_port_inside_cluster}"
  to_port                  = "${var.allowed_ovs_port_inside_cluster}"
  protocol                 = "udp"
  source_security_group_id = "${element(list(module.app.sg,module.infra.sg,module.master.sg), count.index)}"
  security_group_id        = "${module.infra.sg}"
}

//>

//<Allow from master to master
resource "aws_security_group_rule" "allow_ports_tcp_from_master_to_master" {
  count             = "${length(var.allowed_ports_tcp_from_master_to_master)}"
  type              = "ingress"
  from_port         = "${element(var.allowed_ports_tcp_from_master_to_master, count.index)}"
  to_port           = "${element(var.allowed_ports_tcp_from_master_to_master, count.index)}"
  protocol          = "tcp"
  self              = "true"
  security_group_id = "${module.master.sg}"
}

resource "aws_security_group_rule" "allow_ports_udp_from_master_to_master" {
  count             = "${length(var.allowed_ports_udp_from_master_to_master)}"
  type              = "ingress"
  from_port         = "${element(var.allowed_ports_udp_from_master_to_master, count.index)}"
  to_port           = "${element(var.allowed_ports_udp_from_master_to_master, count.index)}"
  protocol          = "udp"
  self              = "true"
  security_group_id = "${module.master.sg}"
}

//>

//< Allow from all nodes to master

resource "aws_security_group_rule" "allow_ports_tcp_from_app_to_master" {
  count                    = "${length(var.allowed_ports_tcp_from_node_to_master)}"
  type                     = "ingress"
  from_port                = "${element(var.allowed_ports_tcp_from_node_to_master, count.index)}"
  to_port                  = "${element(var.allowed_ports_tcp_from_node_to_master, count.index)}"
  protocol                 = "tcp"
  source_security_group_id = "${module.app.sg}"
  security_group_id        = "${module.master.sg}"
}

resource "aws_security_group_rule" "allow_ports_udp_from_app_to_master" {
  count                    = "${length(var.allowed_ports_udp_from_node_to_master)}"
  type                     = "ingress"
  from_port                = "${element(var.allowed_ports_udp_from_node_to_master, count.index)}"
  to_port                  = "${element(var.allowed_ports_udp_from_node_to_master, count.index)}"
  protocol                 = "udp"
  source_security_group_id = "${module.app.sg}"
  security_group_id        = "${module.master.sg}"
}

resource "aws_security_group_rule" "allow_ports_tcp_from_infra_to_master" {
  count                    = "${length(var.allowed_ports_tcp_from_node_to_master)}"
  type                     = "ingress"
  from_port                = "${element(var.allowed_ports_tcp_from_node_to_master, count.index)}"
  to_port                  = "${element(var.allowed_ports_tcp_from_node_to_master, count.index)}"
  protocol                 = "tcp"
  source_security_group_id = "${module.infra.sg}"
  security_group_id        = "${module.master.sg}"
}

resource "aws_security_group_rule" "allow_ports_udp_from_infra_to_master" {
  count                    = "${length(var.allowed_ports_udp_from_node_to_master)}"
  type                     = "ingress"
  from_port                = "${element(var.allowed_ports_udp_from_node_to_master, count.index)}"
  to_port                  = "${element(var.allowed_ports_udp_from_node_to_master, count.index)}"
  protocol                 = "udp"
  source_security_group_id = "${module.infra.sg}"
  security_group_id        = "${module.master.sg}"
}

//>

//<

resource "aws_security_group_rule" "allow_ports_tcp_from_master_inside_cluster" {
  count                    = 3
  type                     = "ingress"
  from_port                = "${element(var.allowed_ports_tcp_from_master_inside_cluster, count.index)}"
  to_port                  = "${element(var.allowed_ports_tcp_from_master_inside_cluster, count.index)}"
  protocol                 = "tcp"
  source_security_group_id = "${module.master.sg}"
  security_group_id        = "${element(list(module.app.sg,module.infra.sg,module.master.sg), count.index)}"
}

//>

//<Public access to infra routers

resource "aws_security_group_rule" "allowed_ports_tcp_from_public_to_infra" {
  count             = "${length(var.allowed_ports_tcp_from_public_to_infra)}"
  type              = "ingress"
  from_port         = "${element(var.allowed_ports_tcp_from_public_to_infra, count.index)}"
  to_port           = "${element(var.allowed_ports_tcp_from_public_to_infra, count.index)}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${module.infra.sg}"
}

//>

