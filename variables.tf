variable "dns_provider" {
  type        = string
  description = "The DNS provider (Route53 currently only supported)"
}
variable "dns_domain_id" {
  type        = string
  description = "The Route53 domain ID"
}
variable "domain" {
  type        = string
  description = "FQDN for the domain"
}
variable "certificate_arn" {
  type        = string
  description = "The certificate ARN provisioned for the domain"
}
