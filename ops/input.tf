variable "aws_region" {
  description = "AWS Region (us-east-1, as-southeast-1, ...)"
  type        = "string"
}

variable "domain_name" {
  description = "Domain name of website to be hosted"
  type        = "string"
}

variable "route_53_zone_id" {
  description = "Zone ID for Route53"
  type        = "string"
}

variable "route_53_name" {
  description = "Route53 Record Name (usually depicting sub domain)"
  type        = "string"
}

variable "cloudfront_cert_acm_arn" {
  description = "ARN for the SSL Certificate used as the Cloudfront Viewer Certificate"
  type        = "string"
}
