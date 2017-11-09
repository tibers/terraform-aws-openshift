resource "aws_kms_key" "parameter_store" {
  description             = "Parameter store kms master key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_iam_instance_profile" "provisioner" {
  role = "${aws_iam_role.provisioner.name}"
}

resource "aws_kms_alias" "parameter_store_alias" {
  name          = "alias/parameter_store_key"
  target_key_id = "${aws_kms_key.parameter_store.id}"
}

resource "aws_iam_role" "provisioner" {
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
              "Principal":{
              "Service": [
                "ec2.amazonaws.com",
                "ssm.amazonaws.com"
              ]
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "provisioner" {
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
      "Effect": "Allow",
      "Action": [
          "ssm:DescribeParameters",
          "ssm:PutParameter",
          "ssm:GetParameters",
          "ssm:DeleteParameter",
          "ssm:SendCommand"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": [
          "sqs:*"
      ],
      "Resource": [
        "${aws_sqs_queue.scaling.arn}"
      ]
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": [
        "kms:ListKeys",
        "kms:ListAliases",
        "kms:Describe*",
        "kms:Encrypt",
        "kms:Decrypt"
      ],
      "Resource": "arn:aws:kms:*:*:key/${aws_kms_key.parameter_store.id}"
    }
  ]
}
EOF
}


resource "aws_iam_policy_attachment" "ssm" {
  name       = "${var.environment}_provisioner"
  roles      = ["${aws_iam_role.provisioner.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "tls_private_key" "provisioner" {
  algorithm = "RSA"
}

resource "aws_ssm_parameter" "provisioner" {
  name  = "${var.environment}.provisioner_id_rsa_pub"
  type  = "String"
  value = "${tls_private_key.provisioner.public_key_openssh}"
  overwrite = "true"
}

resource "aws_ssm_parameter" "provisione_private" {
  name  = "${var.environment}.provisioner_id_rsa"
  type  = "SecureString"
  value = "${tls_private_key.provisioner.private_key_pem}"
  overwrite = "true"
  key_id = "${aws_kms_key.parameter_store.key_id}"
}
