# terralib 

Yet another terraform library 

### Prerequesites
* AWS account configured
* terraform v0.11+
* curl

### Modules 
* AWS VPC
* AWS Auto Scaling Group
* AWS Openshift Origin


### How to
Pending...

## Example

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


