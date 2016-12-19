module "testec2service" {
  source = "../modules/ec2service"
  port            = 80
  subnet_ids      = "${module.vpc.external_subnets}"
  security_groups = ["${module.vpc.security_group}"]
  environment     = "${var.environment}"
  ami             = "ami-eb3b6198"
  instance_key_name = "test"
}
