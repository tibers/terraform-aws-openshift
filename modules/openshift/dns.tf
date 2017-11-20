data "aws_route53_zone" "selected" {
  name = "${var.public_domain}"
}

resource "aws_route53_record" "publicrouter" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "*.public.${var.environment}.${data.aws_route53_zone.selected.name}"
  type    = "A"

  alias {
    name                   = "${aws_elb.infra.dns_name}"
    zone_id                = "${aws_elb.infra.zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "master" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${var.environment}.${data.aws_route53_zone.selected.name}"
  type    = "A"

  alias {
    name                   = "${aws_elb.master.dns_name}"
    zone_id                = "${aws_elb.master.zone_id}"
    evaluate_target_health = false
  }
}
