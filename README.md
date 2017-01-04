# terralib 
Automated cloud reference architecture library based on proven design patterns using Terraform  
##### !! In active POC phase, things change often ... !!


#### AWS

| Module | Description |
| ------ | ----------- |
| VPC | AWS VPC module with built-in parametrized networking, routing, IGW, NAT |

#### Roadmap

| Module   | Provides | Input |
| -------  | -------- | ----- |
| Project  | maps of (IAM, certs, audit, monitoring, compliance, vpc resources)| Regions list, vpc map, peering map, cross region connectivity | 
| Region | Region specific resources | Region resourse maps |
| Service(EC2) | Preconfigured autoscaling service including LB, ASG, Metrics, Scaling policies | Project id, regions, vpc , Spot? ,Service name, environment |

