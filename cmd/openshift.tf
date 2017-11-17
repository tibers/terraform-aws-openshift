module "openshift" {
  source         = "../modules/openshift"
  subnet_ids     = ["${module.vpc.external_subnets}"]
  vpc_id         = "${module.vpc.id}"
  admin_ssh_key  = "${var.admin_ssh_key}"
  management_net = "${chomp(data.http.workstationip.body)}/32"
  public_domain  = "${var.public_domain}"
}
