variable "subdomain" {
  type        = string
  description = "The subdomain"
}
variable "subdomain_suffix" {
  type        = string
  description = "The suffix to append to the subdomain (can be an empty string for no suffix)"
}
variable "domain" {
  type        = string
  description = "The domain (must have an associated Route53 Zone)"
}
