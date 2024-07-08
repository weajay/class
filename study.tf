terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.55.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "devops" {
  name = "stacy"
}

data "aws_iam_policy_document" "module" {
  statement {
    sid = "stacypolicy"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:ListJobs",

    ]

    resources = [
      "arn:aws:s3:::arn:aws:s3:::aws-cloudtrail-logs-284881575168-cad42773/*",
    ]
  }


resource "aws_iam_policy" "newpolicy" {
  name   = "stacypolicy"
  path   = "/"
  policy = data.aws_iam_policy_document.module.json
}

}
resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.devops.name
  policy_arn = aws_iam_policy.newpolicy.arn
}

