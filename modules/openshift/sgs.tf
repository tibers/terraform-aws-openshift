resource "aws_security_group_rule" "allow_ssh_from_provisioner_to_masters" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${module.provisioner.sg}"
  security_group_id        = "${module.master.sg}"
}
