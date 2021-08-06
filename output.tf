output "domain" {
  value       = local.domain
  description = "The complete FQDN for API Gateway"
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
  value       = local.subdomain_suffix
  description = "Re-output of var.subdomain_suffix, or an empty string if it was null"
}
