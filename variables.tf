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

variable "websocket" {
  type        = bool
  description = "Enable a domain for websockets"
  default     = false
}