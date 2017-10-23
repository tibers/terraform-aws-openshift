module "master" {
  source        = "../modules/service"
  subnet_ids    = ["${module.vpc.external_subnets}"]
  environment   = "${var.environment}"
  name          = "master"
  internal      = false
  vpc_id        = "${module.vpc.id}"
  instance_type = "m4.large"

  #CoreOS ami for testing purpose
  ami               = "ami-0d063c6b"
  instance_key_name = "${aws_key_pair.key.key_name}"
}
