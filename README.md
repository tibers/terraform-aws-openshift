# terralib 
Automated cloud reference architecture library based on proven design patterns using Terraform  
##### !! In active POC phase, things change often ... !!


#### AWS

| Module | Description |
| ------ | ----------- |
| VPC | AWS VPC module with built-in parametrized networking, routing, IGW, NAT |

#### Roadmap

### Modules 
* Project - IAM basic, federation, certs, audit, monitoring, cloud trail, compliance, admin, vpc resources, personal VPN 
* VPC Default VPC structure - vpc, subnets, routes, AZ's, NAT/Internet gateways
* Service(EC2) - Preconfigured autoscaling service including LB, ASG, Metrics, Scaling policies 
* VPC Peering - Provides preconfigured peering between 2 VPCs and routes propagated 
* VPC cross region connect - Provides established OpenSwan between 2 VPC in different regions