// Master external API endpoint
output "openshift_master_endpoint" {
  value = "${module.openshift.public_master_endpoint}"
}

output "openshift_private_master_endpoint" {
  value = "${module.openshift.private_master_endpoint}"
}

output "openshift_public_endpoint" {
  value = "${module.openshift.public_endpoint}"
}
