locals {
  subdomain_suffix = var.subdomain_suffix != null ? var.subdomain_suffix : ""
  domain           = local.subdomain_suffix != "" ? "${var.subdomain}-${local.subdomain_suffix}.${var.domain}" : "${var.subdomain}.${var.domain}"
}

data "aws_route53_zone" "zone" {
  name     = "${var.domain}."
  provider = aws.dns
}

resource "aws_acm_certificate" "certificate" {
  domain_name       = local.domain
  validation_method = "DNS"

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "verification_record" {
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 60
  type    = each.value.type
  zone_id = data.aws_route53_zone.zone.zone_id

  # allow_overwrite = true # Dirty hack to allow wildcard certs to not collide

  provider = aws.dns
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = values(aws_route53_record.verification_record)[*].fqdn
}

resource "aws_api_gateway_domain_name" "domain" {
  security_policy = "TLS_1_2"
  certificate_arn = aws_acm_certificate.certificate.arn
  domain_name     = local.domain
}

resource "aws_route53_record" "record" {
  name    = aws_api_gateway_domain_name.domain.domain_name
  type    = "CNAME"
  zone_id = data.aws_route53_zone.zone.zone_id
  ttl     = "300"

  records = [aws_api_gateway_domain_name.domain.cloudfront_domain_name]

  provider = aws.dns
}
