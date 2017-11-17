// ASG name
output "name" {
  value = "${aws_autoscaling_group.asg.name}"
}

// ASG arn
output "arn" {
  value = "${aws_autoscaling_group.asg.arn}"
}

//Default security group
output "sg" {
  value = "${aws_security_group.default.id}"
}
