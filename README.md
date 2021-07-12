[![Maintained by Scaffoldly](https://img.shields.io/badge/maintained%20by-scaffoldly-blueviolet)](https://github.com/scaffoldly)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/scaffoldly/terraform-aws-api-gateway-domain)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.15.0-blue.svg)

## Description

Given an ACM Certificate ARN and a domain, create a domain in API Gateway

## Usage

```hcl
module "domain" {
  source   = "scaffoldly/aws/api-gateway-domain"

  for_each = var.stage_domains

  dns_provider    = lookup(each.value, "dns_provider", "unknown-dns-provider")
  dns_domain_id   = lookup(each.value, "dns_domain_id", "unknown-dns-domain-id")
  domain          = lookup(each.value, "serverless_api_domain", "unknown-domain")
  certificate_arn = lookup(each.value, "certificate_arn", "unknown-arn")

  providers = {
    aws.dns = aws.dns
  }
}
```

<!-- BEGIN_TF_DOCS -->

## Requirements

## Providers

## Modules

## Resources

## Inputs

## Outputs

<!-- END_TF_DOCS -->
