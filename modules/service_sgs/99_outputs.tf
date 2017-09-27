output "aws_security_group_ids" {
  value = ["${aws_security_group.terralib.*.id}"]
}

output "aws_security_group_names" {
  value = ["${aws_security_group.terralib.*.name}"]
}
