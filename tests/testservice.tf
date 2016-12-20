module "testec2service" {
  source = "../modules/ec2service"
  subnet_ids      = ["${module.vpc.external_subnets}"]
  security_groups = ["${module.vpc.security_group}"]
  environment     = "${var.environment}"
  internal        = false
  //CoreOS ami for testing purpose
  ami             = "ami-eb3b6198"
  instance_key_name = "${aws_key_pair.key.key_name}"
}

resource "aws_security_group_rule" "allow_testec2service" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${module.vpc.security_group}"
}

output "testec2service dns name" {
  value = "${module.testec2service.dns}"
}
