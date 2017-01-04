module "service" {
  source = "../modules/service"
  subnet_ids      = ["${module.vpc.external_subnets}"]
  security_groups = ["${module.securitygroup.aws_security_group_ids}"]
  environment     = "${var.environment}"
  internal        = false
  #CoreOS ami for testing purpose
  ami             = "ami-eb3b6198"
  instance_key_name = "${aws_key_pair.key.key_name}"
}

module "securitygroup" {  
  source          = "../modules/service_sgs"
  environment     = "${var.environment}"
  vpc_id          = "${module.vpc.id}"
}

output "service dns name" {
  value = "${module.service.dns}"
}

output "aws_security_group_id" {
  value = "${module.securitygroup.aws_security_group_ids}"
}

output "aws_security_group_name" {
  value = "${module.securitygroup.aws_security_group_names}"
}
