resource "aws_iam_policy" "common" {
  path        = "/"
  description = "Common permissions for all nodes"

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
          "ssm:DescribeParameters",
          "ssm:GetParameters"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:*"
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
    },
    {
          "Effect": "Allow",
           "Action": [
           "logs:CreateLogGroup",
           "logs:CreateLogStream",
           "logs:PutLogEvents",
           "logs:DescribeLogStreams"
       ],
         "Resource": [
           "arn:aws:logs:*:*:*"
         ]
    }
  ]
}
EOF
}
