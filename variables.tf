variable "stage" {
  type        = string
  description = "The stage"
}
variable "subdomain" {
  type        = string
  description = "The subdomain"
}
variable "subdomain_suffix" {
  type        = string
  description = "The (optional) suffix to append to the subdomain"
}
variable "domain" {
  type        = string
  description = "The domain (must have an associated Route53 Zone)"
}
variable "platform_domains" {
  type    = map(string)
  default = {}
}
