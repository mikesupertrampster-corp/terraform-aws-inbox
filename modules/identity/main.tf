resource "aws_ses_domain_identity" "identity" {
  domain = var.domain
}

resource "aws_ses_domain_dkim" "dkim" {
  domain = aws_ses_domain_identity.identity.domain
}

resource "aws_ses_domain_mail_from" "from" {
  domain           = aws_ses_domain_identity.identity.domain
  mail_from_domain = "bounce.${aws_ses_domain_identity.identity.domain}"
}

resource "aws_route53_record" "identity" {
  zone_id = data.aws_route53_zone.apex.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.identity.id}"
  type    = "TXT"
  ttl     = 600
  records = [aws_ses_domain_identity.identity.verification_token]
}

resource "aws_ses_domain_identity_verification" "identity" {
  domain     = aws_ses_domain_identity.identity.id
  depends_on = [aws_route53_record.identity]
}

resource "aws_route53_record" "dkim" {
  count   = 3
  zone_id = data.aws_route53_zone.apex.zone_id
  name    = "${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = 600
  records = ["${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

resource "aws_route53_record" "bounce" {
  zone_id = data.aws_route53_zone.apex.zone_id
  name    = aws_ses_domain_mail_from.from.mail_from_domain
  type    = "MX"
  ttl     = 600
  records = ["10 feedback-smtp.${data.aws_region.current.name}.amazonses.com"]
}

resource "aws_route53_record" "spf" {
  zone_id = data.aws_route53_zone.apex.zone_id
  name    = aws_ses_domain_mail_from.from.mail_from_domain
  type    = "TXT"
  ttl     = 300
  records = ["v=spf1 include:amazonses.com ~all"]
}

resource "aws_ses_receipt_rule_set" "rule_set" {
  for_each      = toset(var.rule_set_names)
  rule_set_name = each.value
}