# CloudFront Module Configuration

# Origin Access Control (S3 + CloudFront)
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${var.project_name}-oac"
  description                       = "OAC for secure S3 access"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront distribution for S3 static website
resource "aws_cloudfront_distribution" "jlcrc2_distribution" {
  origin {
    domain_name              = var.jlcrc2_frontend_bucket_domain_name
    origin_id                = var.jlcrc2_s3_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  price_class         = "PriceClass_100" # for cost optimization
  comment             = "CDN for static website hosting"

  # Domain name
  aliases = ["jlcrc.cloud", "www.jlcrc.cloud"]

  # TLS certificate from ACM in us-east-1  
  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.jlcrc2_s3_origin_id
    compress         = true # for performance optimization

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  logging_config {
    bucket          = "${var.frontend_logs_s3_bucket_name}.s3.amazonaws.com"
    include_cookies = false
    prefix          = "cloudfront-logs/"
  }

  tags = {
    Project = var.project_name
  }
}