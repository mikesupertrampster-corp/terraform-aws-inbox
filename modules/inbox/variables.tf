variable "email" {
  type = string
}

variable "forwarding_emails" {
  type    = list(string)
  default = []
}

variable "rule_set_name" {
  type = string
}
