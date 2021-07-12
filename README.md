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

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.33.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.33.0 |
| <a name="provider_aws.dns"></a> [aws.dns](#provider\_aws.dns) | 3.33.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_domain_name.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_domain_name) | resource |
| [aws_route53_record.record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | The certificate ARN provisioned for the domain | `string` | n/a | yes |
| <a name="input_dns_domain_id"></a> [dns\_domain\_id](#input\_dns\_domain\_id) | The Route53 domain ID | `string` | n/a | yes |
| <a name="input_dns_provider"></a> [dns\_provider](#input\_dns\_provider) | The DNS provider (Route53 currently only supported) | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | FQDN for the domain | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
