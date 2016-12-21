variable "name" {
  description = "Name tag, e.g stack"
  default     = "stack"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "vpc_id" {
  description = "Vpc id"
}
