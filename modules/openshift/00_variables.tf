variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "vpc_id" {
  description = "VPC id which will host openshift"
}

variable "subnet_ids" {
  description = "List of Subnets"
  type        = "list"
}

variable "instance_key_name" {
  description = "Instance key name"
  default     = "default_instance_key"
}