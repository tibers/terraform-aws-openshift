module "elb" {
  source = "../modules/elb"

  subnet_ids      = "${module.vpc.external_subnets}"
  security_groups = ["${module.vpc.security_group}"]
  environment     = "${var.environment}"
}
