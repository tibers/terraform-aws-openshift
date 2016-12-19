provider "aws" {
    region = "eu-west-1"
}


variable "instance_key" {
  description = "ssh key"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCb5J7XJS2p9+1udlNs2sec8SgCm+dCEGzWlrxGA/YFU7mVcGWtKbmiXJEMdboRWO7qnjyQAAKC0WZTu3yK/ubIqgJDuGL9WkSaFhucCUy5JUYEGMG2kUlC7mgtYcr4db11LmgL27k2AuyTErdU6+Kj8NqPBRennMEX+B8tYrXn+p/bSXizlDXc49iYfEOInDY7xuKhy5mMIOBmPh+aTEa5TqLimrRUuTk6KZ4/K3C/QuPuOq3Ks6yUkGsNAU9oVD5+1uPe6fJvrT1KdAj3mae/bJzegq8GQAU50SODyo8qkw1OtPFzDmVwkEtdq0p298DL4o1OaElHIEoypfr08+Dx nixlike@oleksiis-mbp-3.kyiv.epam.com
"
}

variable "name" {
  description = "the name of your stack"
  default     = "defaultname"
}

variable "environment" {
  description = "the name of your environment"
  default     = "testenv"
}

variable "cidr" {
  description = "the CIDR block to provision for the VPC"
  default     = "10.50.0.0/16"
}

variable "internal_subnets" {
  description = "a list of CIDRs for internal subnets in your VPC"
  //default     = ["10.50.0.0/19" ,"10.50.64.0/19", "10.50.128.0/19"]
  default     = ["10.50.0.0/19"]
}

variable "external_subnets" {
  description = "a list of CIDRs for external subnets in your VPC"
  //default     = ["10.50.32.0/20", "10.50.96.0/20", "10.50.160.0/20"]
  default     = ["10.50.32.0/20"]
}

variable "availability_zones" {
  description = "a comma-separated list of availability zones"
  //default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  default     = ["eu-west-1a"]
}
