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

variable "instance_key_name" {
  description = "Instance key name"
  default     = "default_instance_key"
}

variable "user_data" {
}



variable "internal" {
  description = "ELB type"
  default     = "true"
}

variable "own_security_group" {
  description = "Place service into separate security group ?"
  default     = "false"
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

variable "lb_port" {
  description = "LB port"
  default     = 80
}

variable "instance_port" {
  description = "instance port"
  default     = 80
}

variable "healthcheck" {
  description = "Healthcheck path"
  default     = "/"
}

variable "protocol" {
  description = "Protocol to use, HTTP or TCP"
  default     = "HTTP"
}
