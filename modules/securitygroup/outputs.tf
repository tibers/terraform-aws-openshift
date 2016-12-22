output "aws_security_group_id" {
  value = ["${aws_security_group.terralib.id}"]
}

output "aws_security_group_name" {
  value = "${aws_security_group.terralib.name}"
}
