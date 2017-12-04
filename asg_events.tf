resource "aws_sns_topic" "scaling" {
  name = "${var.environment}_scaling"
}

resource "aws_sqs_queue" "scaling" {
  name = "${var.environment}_scaling"
}

resource "aws_autoscaling_notification" "scaling" {
  group_names = [
    "${module.master.name}",
    "${module.infra.name}",
    "${module.app.name}",
    "${module.provisioner.name}",
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

resource "aws_cloudwatch_event_rule" "openshift_scaleout" {
  name        = "${var.environment}"
  description = "Scale out"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.autoscaling"
  ],
  "detail-type": [
    "EC2 Instance Launch Successful"
  ],
  "detail": {
    "AutoScalingGroupName": [
      "${module.master.name}",
      "${module.infra.name}",
      "${module.app.name}",
      "${module.provisioner.name}"
    ]
  }
}

PATTERN
}

resource "aws_cloudwatch_event_target" "provisioner" {
  rule     = "${aws_cloudwatch_event_rule.openshift_scaleout.name}"
  arn      = "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:document/${aws_ssm_document.openshift.name}"
  role_arn = "${aws_iam_role.events.arn}"

  run_command_targets {
    key    = "tag:Name"
    values = ["provisioner"]
  }
}

resource "aws_iam_role" "events" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "events" {
  role = "${aws_iam_role.events.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": [
        "*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
