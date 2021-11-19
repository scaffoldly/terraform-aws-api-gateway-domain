[![Maintained by Scaffoldly](https://img.shields.io/badge/maintained%20by-scaffoldly-blueviolet)](https://github.com/scaffoldly)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/scaffoldly/terraform-aws-api-gateway-domain)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.15.0-blue.svg)

## Description

Given an ACM Certificate ARN and a domain, create a domain in API Gateway

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 1.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.53.0 |
| <a name="provider_aws.dns"></a> [aws.dns](#provider\_aws.dns) | 3.53.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_api_gateway_domain_name.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_domain_name) | resource |
| [aws_apigatewayv2_domain_name.ws_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_domain_name) | resource |
| [aws_route53_record.record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.record_cname](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.verification_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | The domain (must have an associated Route53 Zone) | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | The stage | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The subdomain | `string` | n/a | yes |
| <a name="input_subdomain_suffix"></a> [subdomain\_suffix](#input\_subdomain\_suffix) | The (optional) suffix to append to the subdomain | `string` | n/a | yes |
| <a name="input_websockets"></a> [websockets](#input\_websockets) | Enable a domain for websockets | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_gateway_domain"></a> [api\_gateway\_domain](#output\_api\_gateway\_domain) | The complete FQDN for API Gateway |
| <a name="output_api_gateway_websocket_domain"></a> [api\_gateway\_websocket\_domain](#output\_api\_gateway\_websocket\_domain) | The complete FQDN for API Gateway Websockets |
| <a name="output_api_gateway_websocket_domain_id"></a> [api\_gateway\_websocket\_domain\_id](#output\_api\_gateway\_websocket\_domain\_id) | The domain ID for API Gateway Websockets |
| <a name="output_domain"></a> [domain](#output\_domain) | Re-output of var.domain |
| <a name="output_stage"></a> [stage](#output\_stage) | Re-output of var.stage |
| <a name="output_subdomain"></a> [subdomain](#output\_subdomain) | Re-output of var.subdomain |
| <a name="output_subdomain_suffix"></a> [subdomain\_suffix](#output\_subdomain\_suffix) | Re-output of var.subdomain\_suffix |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | The Zone ID for this stage |
<!-- END_TF_DOCS -->
