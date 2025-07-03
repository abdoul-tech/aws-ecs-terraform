resource "aws_route53_record" "dns_principal" {
  for_each = toset(var.domaines)

  zone_id = var.dns_zone_id
  name    = each.value
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = var.cloudfront_main_domain_name
    zone_id                = "Z2FDTNDATAQYW2" # This is always the hosted zone ID when you create an alias record that routes traffic to a CloudFront distribution.
  }
}
