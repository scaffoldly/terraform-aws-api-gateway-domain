output "domain" {
  value       = var.domain
  description = "Re-output of var.domain"
}
output "stage" {
  value       = var.stage
  description = "Re-output of var.stage"
}
output "subdomain" {
  value       = var.subdomain
  description = "Re-output of var.subdomain"
}
output "subdomain_suffix" {
  value       = var.subdomain_suffix
  description = "Re-output of var.subdomain_suffix"
}
output "api_gateway_domain" {
  value       = local.domain
  description = "The complete FQDN for API Gateway"
}
output "zone_id" {
  value       = data.aws_route53_zone.zone.zone_id
  description = "The Zone ID for this stage"
}
