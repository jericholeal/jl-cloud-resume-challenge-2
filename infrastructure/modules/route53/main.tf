# Route53 Module Configuration

# Hosted zone
resource "aws_route53_zone" "jlcrc2_route53_zone" {
  name = var.jlcrc2_domain_name
  tags = {
    Project = var.project_name
  }
}

# Alias record pointing to CloudFront distribution
resource "aws_route53_record" "jlcrc2_cdn_alias" {
  zone_id = aws_route53_zone.jlcrc2_route53_zone.zone_id
  name    = var.jlcrc2_domain_name
  type    = "A"

  depends_on = [aws_cloudfront_distribution.jlcrc2_distribution]

  alias {
    name                   = var.jlcrc2_distribution_domain_name
    zone_id                = aws_route53_zone.jlcrc2_route53_zone.zone_id
    evaluate_target_health = false
  }
}

# www subdomain alias record redirecting to root domain
resource "aws_route53_record" "jlcrc_zone_www_alias" {
  zone_id    = aws_route53_zone.jlcrc2_route53_zone.zone_id
  name       = "www.${var.jlcrc2_domain_name}"
  type       = "CNAME"
  ttl        = 300
  records    = [var.jlcrc2_domain_name]
}