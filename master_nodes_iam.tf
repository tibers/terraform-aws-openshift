resource "aws_iam_role" "master" {
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

resource "aws_iam_instance_profile" "master" {
  role = "${aws_iam_role.master.name}"
}

resource "aws_iam_role_policy_attachment" "master_common" {
  role       = "${aws_iam_role.master.name}"
  policy_arn = "${aws_iam_policy.common.arn}"
}
