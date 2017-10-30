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

variable "provisioner_ami" {
   default =   "ami-0d063c6b"
}

variable "provisioner_instance_type" {
   default =   "m4.large"
}

variable "provisioner_user_data" {
  default     = "../modules/openshift/vagrant/user-data.tpl"
}

variable "provisioner_user_data_rendered" {
  default     = "../modules/openshift/vagrant/user-data"
}

variable "provisioner_name" { 
  default     = "provisioner"
}