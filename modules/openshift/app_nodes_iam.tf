resource "aws_iam_role" "app" {
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

resource "aws_iam_instance_profile" "app" {
  role = "${aws_iam_role.app.name}"
}

resource "aws_iam_role_policy_attachment" "app_common" {
  role       = "${aws_iam_role.app.name}"
  policy_arn = "${aws_iam_policy.common.arn}"
}
