// Master external API endpoint
output "openshift_master_endpoint" {
  value = "${module.openshift.master_endpoint}"
}

output "openshift_public_endpoint" {
  value = "${module.openshift.public_endpoint}"
}
