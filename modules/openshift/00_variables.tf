variable "environment" {
  description = "Environment tag, e.g prod"
  default     = "default"
}

variable "vpc_id" {
  description = "VPC id which will host openshift"
}

variable "subnet_ids" {
  description = "List of Subnets"
  type        = "list"
}

variable "admin_ssh_key" {
  description = "Instance key name"
  default     = ""
}

variable "management_net" {}

variable "public_domain" {
  description = "Public domain name used as parent for all environments"
}

variable "provisioner_ami" {
  default = "ami-0d063c6b"
}

variable "provisioner_instance_type" {
  default = "m4.large"
}

variable "provisioner_user_data" {
  default = "../modules/openshift/provisioner-user-data.tpl"
}

variable "provisioner_name" {
  default = "provisioner"
}

variable "master_ami" {
  default = "ami-0d063c6b"
}

variable "master_instance_type" {
  default = "m4.large"
}

variable "master_user_data" {
  default = "../modules/openshift/master-user-data.tpl"
}

variable "master_name" {
  default = "master"
}

