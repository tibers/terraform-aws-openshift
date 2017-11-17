// Master external API endpoint
output "openshift_public_hostname" {
  value = "${module.openshift.master_public_endpoint}"
}
