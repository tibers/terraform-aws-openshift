resource "aws_iam_role" "infra" {
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }

    ]
}
EOF
}

resource "aws_iam_instance_profile" "infra" {
  role = "${aws_iam_role.infra.name}"
}

resource "aws_iam_role_policy_attachment" "infra_common" {
  role       = "${aws_iam_role.infra.name}"
  policy_arn = "${aws_iam_policy.common.arn}"
}
