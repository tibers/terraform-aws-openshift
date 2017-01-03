// The ELB name.
output "name" {
  value = "${aws_elb.elb.name}"
}

// The ELB ID.
output "id" {
  value = "${aws_elb.elb.id}"
}

// The ELB dns_name.
output "dns" {
  value = "${aws_elb.elb.dns_name}"
}

// The zone id of the ELB
output "zone_id" {
  value = "${aws_elb.elb.zone_id}"
}
