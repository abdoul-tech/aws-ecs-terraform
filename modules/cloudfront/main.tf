resource "aws_cloudfront_distribution" "distribution" {
  comment = "${var.application_name}-${terraform.workspace}"
  origin {
    domain_name = var.dns_name
    origin_id   = var.dns_name
    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols     = ["TLSv1.2"]
    }
  }

  aliases = var.aliases
  
  viewer_certificate {
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = "sni-only"
  }

  price_class     = "PriceClass_All"
  enabled         = true
  is_ipv6_enabled = false

  default_cache_behavior {
    #    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" ### default AWS
    allowed_methods = [
      "GET",
      "HEAD",
      "OPTIONS",
      "DELETE",
      "PATCH",
      "POST",
      "PUT",
    ]

    forwarded_values {
      headers = [
        "*",
      ]
      query_string            = true
      query_string_cache_keys = []

      cookies {
        forward           = "all"
        whitelisted_names = []
      }
    }

    target_origin_id = var.dns_name
    cached_methods   = [
      "GET",
      "HEAD",
    ]
    compress               = true
    default_ttl            = 0
    max_ttl                = 0
    min_ttl                = 0
    smooth_streaming       = false
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }

  tags = merge(
    var.default_tags,
    {
      component = "cloudfront"
    },
  )
}