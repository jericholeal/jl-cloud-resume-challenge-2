# Route 53 Module Outputs

output "jlcrc2_route53_zone_id" {
  description = "ID of Route53 hosted zone for jlcrc.cloud"
  value       = aws_route53_zone.jlcrc2_route53_zone.zone_id
}