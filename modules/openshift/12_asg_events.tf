resource "aws_sns_topic" "scaling" {
  name = "${var.environment}_scaling"
}

resource "aws_sqs_queue" "scaling" {
  name = "${var.environment}_scaling"
}

resource "aws_autoscaling_notification" "scaling" {
  group_names = [
    "${module.master.name}",
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
  ]

  topic_arn = "${aws_sns_topic.scaling.arn}"
}

resource "aws_sns_topic_subscription" "scaling" {
  topic_arn = "${aws_sns_topic.scaling.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.scaling.arn}"
}

resource "aws_sqs_queue_policy" "scaling" {
  queue_url = "${aws_sqs_queue.scaling.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "${aws_sqs_queue.scaling.name}",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.scaling.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.scaling.arn}"
        }
      }
    }
  ]
}
POLICY
}