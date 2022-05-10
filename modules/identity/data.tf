data "aws_region" "current" {}

data "aws_route53_zone" "apex" {
  name         = var.domain
  private_zone = false
}