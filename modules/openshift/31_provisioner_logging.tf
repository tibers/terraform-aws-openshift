resource "aws_cloudwatch_log_group" "openshift" {
    name       = "${var.environment}"

  tags {
    Environment = "${var.environment}"
    Name = "provisioner"
  }
}