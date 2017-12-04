# terraform-aws-openshift 

Autoscaling OpenShift Terraform module for AWS

## Features
* 100% native ansible provisioning method, using AWS dynamic inventory.
* Module allows size your claster from 1 to 300 nodes, any Openshift component: Masters, Infra and App nodes implemented as Auto Scaling groups


## Architecture

 ![alt text](https://blog.openshift.com/wp-content/uploads/refarch-ocp-on-aws-v3.png "Origin")

### Prerequesites
* AWS account configured
* Previously created Route53 hosted zone (will be used for environment dns names creation)
* terraform v0.11+
* curl

## Usage

The below example deploys multi AZ OpenShift Origin with autoscaling enabled

### Example

```terraform
module "openshift" {
  source             = "odzhu/openshift/aws"
  public_subnet_ids  = ["${module.vpc.external_subnets}"]
  private_subnet_ids = ["${module.vpc.internal_subnets}"]
  vpc_id             = "${module.vpc.id}"
  admin_ssh_key      = "${var.admin_ssh_key}"
  management_net     = "${chomp(data.http.workstationip.body)}/32"
  public_domain      = "${var.public_domain}"
  app_node_count     = "1"
  infra_node_count   = "1"
  master_node_count  = "1"
}
```
or

```bash
$ cd ./cmd
$ admin_ssh_key=$(cat ~/.ssh/id_rsa.pub) public_domain=your_AWS_hosted_zone_domain make -e

Outputs:

openshift_master_endpoint = https://your_AWS_hosted_zone_domain:8443
openshift_public_endpoint = https://public.your_AWS_hosted_zone_domain
```

## FAQ

1. The module provisioning finished by ***openshift_master_endpoint*** is not accessible

Cluster provisioning continues in background and takes around 30 min depending on instance size. You can monitor progress by logging ***provisioner node*** and watching /tmp/provisioning.log
