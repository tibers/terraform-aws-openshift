module "provisioner" {
  source        = "../service"
  subnet_ids    = "${var.subnet_ids}"
  environment   = "${var.environment}"
  name          = "master"
  internal      = false
  vpc_id        = "${var.vpc_id}"
  instance_type = "m4.large"
  instance_profile = "${aws_iam_instance_profile.provisioner.name}"

  #CoreOS ami for testing purpose
  ami               = "ami-0d063c6b"
  instance_key_name = "${var.instance_key_name}"
}