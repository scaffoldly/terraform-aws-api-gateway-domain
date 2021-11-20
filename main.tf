locals {
  domain           = var.subdomain_suffix != "" ? "${var.subdomain}-${var.subdomain_suffix}.${var.domain}" : "${var.subdomain}.${var.domain}"
  websocket_domain = "ws-${local.domain}"
}

data "aws_route53_zone" "zone" {
  name     = var.domain
  provider = aws.dns
}

resource "aws_acm_certificate" "certificate" {
  domain_name               = local.domain
  subject_alternative_names = var.websocket ? [local.websocket_domain] : null
  validation_method         = "DNS"

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

  allow_overwrite = true

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

  depends_on = [
    aws_acm_certificate_validation.validation
  ]
}

resource "aws_apigatewayv2_domain_name" "ws_domain" {
  count = var.websocket ? 1 : 0

  domain_name = local.websocket_domain

  domain_name_configuration {
    certificate_arn = aws_acm_certificate.certificate.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  depends_on = [
    aws_acm_certificate_validation.validation
  ]
}

resource "aws_route53_record" "record" {
  name    = local.domain
  type    = "CNAME"
  zone_id = data.aws_route53_zone.zone.zone_id
  ttl     = "300"

  records = [aws_api_gateway_domain_name.domain.cloudfront_domain_name]

  allow_overwrite = true

  provider = aws.dns
}

resource "aws_route53_record" "record_cname" {
  count = var.websocket ? 1 : 0

  name    = local.websocket_domain
  type    = "CNAME"
  zone_id = data.aws_route53_zone.zone.zone_id
  ttl     = "300"

  records = [aws_apigatewayv2_domain_name.ws_domain[count.index].domain_name_configuration[0].target_domain_name]

  allow_overwrite = true

  provider = aws.dns
}
