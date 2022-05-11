provider "aws" {
  region = var.region

  default_tags {
    tags = var.tags
  }
}

module "identity" {
  source            = "../../../modules//identity"
  domain            = var.apex_domain
  forwarding_emails = var.forwarding_emails
}
