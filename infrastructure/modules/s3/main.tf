# S3 Module Configuration

resource "aws_s3_bucket" "jlcrc2_frontend_bucket" {
  bucket = var.frontend_s3_bucket_name
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Project = var.project_name
    Purpose = "Static website hosting"
  }
}

resource "aws_s3_bucket_policy" "jlcrc2_frontend_policy" {
  bucket = aws_s3_bucket.jlcrc2_frontend_bucket.id

  policy = jsonencode({
    "Version" = "2012-10-17",
    "Id"      = "PolicyForCloudFrontPrivateContent",
    "Statement" = [
      {
        "Sid" = "AllowCloudFrontServicePrincipal",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudfront.amazonaws.com"
        },
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::${var.frontend_s3_bucket_name}/*",
        "Condition" : {
          "StringEquals" : {
            "AWS:SourceArn" : "arn:aws:cloudfront::${var.account_id}:origin-access-control/${var.jlcrc2_oac_id}"
          }
        }
      }
    ]
  })
}
resource "aws_s3_bucket_server_side_encryption_configuration" "jlcrc2_frontend_encryption" {
  bucket = aws_s3_bucket.jlcrc2_frontend_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "jlcrc2_frontend_bucket_versioning" {
  bucket = aws_s3_bucket.jlcrc2_frontend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# jlcrc2-frontend-logs S3 bucket configuration

resource "aws_s3_bucket" "jlcrc2_frontend_logs_bucket" {
  bucket = var.frontend_logs_s3_bucket_name
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Project = var.project_name
    Purpose = "CloudFront logging"
  }
}
resource "aws_s3_bucket_versioning" "jlcrc2_frontend_logs_versioning" {
  bucket = aws_s3_bucket.jlcrc2_frontend_logs_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "jlcrc2_frontend_logs_policy" {
  bucket = aws_s3_bucket.jlcrc2_frontend_logs_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "delivery.logs.amazonaws.com"
      },
      Action   = "s3:PutObject",
      Resource = "arn:aws:s3:::${var.frontend_logs_s3_bucket_name}/*",
      Condition = {
        StringEquals = {
          "AWS:SourceAccount" = "${var.account_id}"
        }
      }
    }]
  })
}

# jlcrc2-lambda S3 bucket configuration

resource "aws_s3_bucket" "jlcrc2_lambda_bucket" {
  bucket = var.lambda_s3_bucket_name
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Project = var.project_name
    Purpose = "Lambda function code storage"
  }
}

resource "aws_s3_bucket_versioning" "jlcrc2_lambda_bucket_versioning" {
  bucket = aws_s3_bucket.jlcrc2_lambda_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "jlcrc2_lambda_bucket_policy" {
  bucket = aws_s3_bucket.jlcrc2_lambda_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        AWS = "${var.jlcrc2_lambda_exec_role_arn}"
      },
      Action   = "s3:GetObject",
      Resource = "arn:aws:s3:::${var.lambda_s3_bucket_name}/*"
    }]
  })
}

# jlcrc2-terraform-state S3 bucket configuration

resource "aws_s3_bucket" "jlcrc2_terraform_state_bucket" {
  bucket = var.terraform_state_bucket_name
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Project = var.project_name
    Purpose = "Terraform state storage"
  }
}
resource "aws_s3_bucket_versioning" "jlcrc2_terraform_state_bucket_versioning" {
  bucket = aws_s3_bucket.jlcrc2_terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

