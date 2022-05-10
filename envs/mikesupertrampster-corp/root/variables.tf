variable "apex_domain" {
  type = string
}

variable "environment" {
  type = string
}

variable "forwarding_emails" {
  type = list(string)
}

variable "region" {
  type = string
}

variable "tags" {
  type = map(string)
}
