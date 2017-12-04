data "aws_caller_identity" "current" {}

resource "aws_key_pair" "admin_key" {
  key_name   = "${var.environment}"
  public_key = "${var.admin_ssh_key}"
}
