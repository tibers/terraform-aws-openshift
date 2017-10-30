//Service default security groups
output "sg_ids" {
  value = "${module.securitygroup.aws_security_group_ids}"
}
