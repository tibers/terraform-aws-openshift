//Service default security groups
output "sg_id" {
  value = "${aws_security_group.default.id}"
}
