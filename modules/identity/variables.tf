variable "domain" {
  type = string
}

output "domain" {
  value = aws_ses_domain_identity.identity.domain
}

