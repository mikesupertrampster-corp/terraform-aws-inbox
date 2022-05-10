variable "domain" {
  type = string
}

variable "rule_set_names" {
  type = list(string)
}

output "domain" {
  value = aws_ses_domain_identity.identity.domain
}