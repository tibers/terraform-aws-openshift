module "openshift" {
  source        = "../modules/openshift"
  subnet_ids    = ["${module.vpc.external_subnets}"]
  environment   = "${var.environment}"
  vpc_id        = "${module.vpc.id}"
  instance_key_name = "${aws_key_pair.key.key_name}"
  management_net  = "${chomp(data.http.workstationip.body)}/32"
}
