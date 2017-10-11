resource "aws_iam_instance_profile" "provisioner" {
  name  = "provisioner"
  role = "${aws_iam_role.provisioner.name}"
}

resource "aws_iam_role" "provisioner" {
  name = "provisioner"
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

resource "aws_iam_role_policy" "provisioner" {
  name = "provisioner"
  role = "${aws_iam_role.provisioner.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}