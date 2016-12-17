variable "name" {
  description = "ELB name"
  default     = "unset"
}

variable "subnet_ids" {
  description = "List of Subnets"
  type        = "list"
}

variable "environment" {
  description = "Environment tag, e.g prod"
  default     = "unset"
}

variable "port" {
  description = "Instance port"
}

variable "security_groups" {
  description = "List of Security Groups"
  type        = "list"
}

variable "healthcheck" {
  description = "Healthcheck path"
  default     = "/"
}

variable "protocol" {
  description = "Protocol to use, HTTP or TCP"
  default     = "HTTP"
}

/**
 * Resources.
 */

resource "aws_elb" "main" {
  name = "${var.name}"

  internal                  = true
  cross_zone_load_balancing = true
  subnets                   = ["${var.subnet_ids}"]
  security_groups           = ["${var.security_groups}"]

  idle_timeout                = 30
  connection_draining         = true
  connection_draining_timeout = 15

  listener {
    lb_port           = 80
    lb_protocol       = "${var.protocol}"
    instance_port     = "${var.port}"
    instance_protocol = "${var.protocol}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "${var.protocol}:${var.port}${var.healthcheck}"
    interval            = 30
  }

  tags {
    Name        = "${var.name}-balancer"
    Service     = "${var.name}"
    Environment = "${var.environment}"
  }
}
/**
 * Outputs.
 */

// The ELB name.
output "name" {
  value = "${aws_elb.main.name}"
}

// The ELB ID.
output "id" {
  value = "${aws_elb.main.id}"
}

// The ELB dns_name.
output "dns" {
  value = "${aws_elb.main.dns_name}"
}

// The zone id of the ELB
output "zone_id" {
  value = "${aws_elb.main.zone_id}"
}
