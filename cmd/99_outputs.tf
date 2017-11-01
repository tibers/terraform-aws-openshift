// Master external API endpoint
output "openshift_public_hostname" {
  value = "${module.openshift.openshift_public_hostname}"
}
