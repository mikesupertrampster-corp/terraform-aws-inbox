provider "aws" {
  region = var.region

  default_tags {
    tags = var.tags
  }
}

module "identity" {
  source         = "../../../modules//identity"
  domain         = var.apex_domain
  rule_set_names = ["inbox"]
}

module "inbox" {
  for_each          = toset(formatlist("%s@${module.identity.domain}", ["me"]))
  source            = "../../../modules//inbox"
  rule_set_name     = "inbox"
  email             = each.value
  forwarding_emails = var.forwarding_emails
}
