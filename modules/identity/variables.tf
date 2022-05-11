variable "domain" {
  type = string
}

variable "forwarding_emails" {
  type    = list(string)
  default = []
}

output "domain" {
  value = aws_ses_domain_identity.identity.domain
}
