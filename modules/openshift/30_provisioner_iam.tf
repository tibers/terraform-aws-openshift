resource "aws_kms_key" "parameter_store" {
  description             = "Parameter store kms master key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_iam_instance_profile" "provisioner" {
  name  = "provisioner"
  role = "${aws_iam_role.provisioner.name}"
}

resource "aws_kms_alias" "parameter_store_alias" {
  name          = "alias/parameter_store_key"
  target_key_id = "${aws_kms_key.parameter_store.id}"
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
                "ec2:Describe*",
                "route53:ListHostedZones",
                "route53:ListResourceRecordSets",
                "rds:Describe*",
                "elasticache:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": [
        "ssm:GetParameters",
        "ssm:DescribeParameters"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": [
        "kms:ListKeys",
        "kms:ListAliases",
        "kms:Describe*",
        "kms:Decrypt"
      ],
      "Resource": "arn:aws:kms:*:*:key/${aws_kms_key.parameter_store.id}"
    }
  ]
}
EOF
}