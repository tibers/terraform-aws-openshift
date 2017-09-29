module "service" {
  source          = "../modules/service"
  subnet_ids      = ["${module.vpc.external_subnets}"]
  environment     = "${var.environment}"
  internal        = false
  vpc_id          = "${module.vpc.id}"

  #CoreOS ami for testing purpose
  ami               = "ami-eb3b6198"
  instance_key_name = "${aws_key_pair.key.key_name}"
}

output "service dns name" {
  value = "${module.service.dns}"
}
