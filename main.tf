resource "aws_api_gateway_domain_name" "domain" {
  security_policy = "TLS_1_2"
  certificate_arn = var.certificate_arn
  domain_name     = var.domain
}

resource "aws_route53_record" "record" {
  count = var.dns_provider == "aws" ? 1 : 0

  name    = aws_api_gateway_domain_name.domain.domain_name
  type    = "CNAME"
  zone_id = var.dns_domain_id
  ttl     = "300"

  records = [aws_api_gateway_domain_name.domain.cloudfront_domain_name]

  provider = aws.dns
}
