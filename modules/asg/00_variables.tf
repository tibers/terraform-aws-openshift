variable "name" {
  description = "Name tag, e.g stack"
  default     = "stack"
}

variable "vpc_id" {
  description = "Vpc id"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "ami" {
  description = "AMI for the instance"
}

variable "instance_profile" {
  description = "Instance profile for the service"
}

variable "subnet_ids" {
  description = "List of Subnets"
  type        = "list"
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.nano"
}

variable "admin_ssh_key" {
  description = "Instance key name"
  default     = "default_instance_key"
}

variable "user_data" {}

variable "security_groups" {
  type = "list"
}

variable "max_size" {
  description = "ASG max size"
  default     = 1
}

variable "min_size" {
  description = "ASG min size"
  default     = 1
}

variable "desired_capacity" {
  description = "ASG desired capacity"
  default     = 1
}

variable "load_balancers" {
  description = "Load Balancers to attach the ASG"
  type        = "list"
}

variable "spot_price" {
  description = "Spot market price"
  default     = "0.1"
}
