// Delay untill master is provisioned
resource "null_resource" "validate_master_api" {
  provisioner "local-exec" {
    command = "while ! curl -k -q ${module.openshift.master_public_endpoint}|grep -i healthz; do echo retry;done"
    interpreter = ["bash", "-c"]
  }
}