resource "aws_route53_record" "www" {
  zone_id = var.route_53_zone_id
  name    = var.route_53_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.default.domain_name
    zone_id                = aws_cloudfront_distribution.default.hosted_zone_id
    evaluate_target_health = false
  }
}