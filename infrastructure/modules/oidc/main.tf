# OIDC Configuration for GitHub Actions

resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}


# GitHub OIDC Role, Backend Deployment

resource "aws_iam_role" "github_oidc_backend_deploy_role" {
  name = var.github_oidc_backend_deploy_role_name
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${var.account_id}:oidc-provider/token.actions.githubusercontent.com"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "token.actions.githubusercontent.com:sub" : "repo:${var.github_username}/${var.github_repo_name}:ref:refs/heads/main",
            "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "github_oidc_backend_deploy_permissions" {
  role = aws_iam_role.github_oidc_backend_deploy_role.name
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*",
          "dynamodb:*",
          "lambda:*",
          "cloudfront:*",
          "cloudwatch:*",
          "apigateway:*",
          "route53:*",
          "acm:*",
          "logs:*",
          "iam:PassRole"
        ],
        "Resource" : [

        ]
      }
    ]
  })
}

# GitHub OIDC Role, Frontend Deployment

resource "aws_iam_role" "github_oidc_frontend_deploy_role" {
  name = var.github_oidc_frontend_deploy_role_name
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${var.account_id}:oidc-provider/token.actions.githubusercontent.com"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "token.actions.githubusercontent.com:sub" : "repo:${var.github_username}/${var.github_repo_name}:ref:refs/heads/main",
            "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "github_oidc_frontend_deploy_permissions" {
  role = aws_iam_role.github_oidc_frontend_deploy_role.name
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:PutObjectAcl",
        ],
        "Resource" : [
          "arn:aws:s3:::${var.frontend_s3_bucket_name}/*",
          "arn:aws:s3:::${var.frontend_logs_s3_bucket_name}/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "cloudfront:CreateInvalidation",
        ],
        "Resource" : "*"
      }
    ]
  })
}