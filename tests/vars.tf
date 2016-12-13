provider "aws" {
    region = "eu-west-1"
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
//  default     = ["10.50.0.0/19" ,"10.50.64.0/19", "10.50.128.0/19"]
  default     = ["10.50.0.0/19"]
}

variable "external_subnets" {
  description = "a list of CIDRs for external subnets in your VPC"
//  default     = ["10.50.32.0/20", "10.50.96.0/20", "10.50.160.0/20"]
  default     = ["10.50.32.0/20"]
}

variable "availability_zones" {
  description = "a comma-separated list of availability zones"
//  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  default     = ["eu-west-1b"]
}
