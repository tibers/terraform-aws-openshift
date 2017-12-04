# terralib-openshift 

Autoscaling OpenShift Terraform module

## Features
* 100% native ansible provisioning method, using AWS dynamic inventory.
* Module allows size your claster from 1 to 300 nodes, any Openshift component: Masters, Infra and App nodes implemented as Auto Scaling groups

### Prerequesites
* AWS account configured
* Previously created Route53 hosted zone (will be used for environment dns names creation)
* terraform v0.11+
* curl

## Usage

The below example deploys multi AZ OpenShift Origin with autoscaling enabled

```bash
$ cd ./cmd
$ admin_ssh_key=$(cat ~/.ssh/id_rsa.pub) public_domain=your_AWS_hosted_zone_domain make -e

Outputs:

openshift_master_endpoint = https://your_AWS_hosted_zone_domain:8443
openshift_public_endpoint = https://public.your_AWS_hosted_zone_domain
```

## Architecture

 ![alt text](https://blog.openshift.com/wp-content/uploads/refarch-ocp-on-aws-v3.png "Origin")


