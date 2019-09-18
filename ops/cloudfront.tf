resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Cloudfront Origin Access Identity for ${var.domain_name}"
}

locals {
  s3_origin_id = "S3-${var.domain_name}"
}

resource "aws_cloudfront_distribution" "default" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Cloudfront Distribution for ${var.domain_name}"
  default_root_object = "index.html"
  price_class         = "PriceClass_200"
  depends_on          = [aws_s3_bucket.aws_s3_bucket]

  aliases = [var.domain_name]

  origin {
    domain_name = aws_s3_bucket.aws_s3_bucket.website_endpoint
    origin_id   = local.s3_origin_id

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.cloudfront_cert_acm_arn
    minimum_protocol_version = "TLSv1"
    ssl_support_method = "sni-only"
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    default_ttl            = 3600
    min_ttl                = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  wait_for_deployment = true
}