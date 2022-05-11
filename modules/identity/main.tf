resource "aws_ses_domain_identity" "identity" {
  domain = var.domain
}

resource "aws_ses_domain_dkim" "dkim" {
  domain = aws_ses_domain_identity.identity.domain
}

resource "aws_route53_record" "dkim" {
  count   = 3
  zone_id = data.aws_route53_zone.apex.zone_id
  name    = "${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = 1800
  records = ["${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

resource "aws_route53_record" "mx" {
  zone_id = data.aws_route53_zone.apex.zone_id
  name    = aws_ses_domain_identity.identity.domain
  type    = "MX"
  ttl     = 300
  records = ["10 inbound-smtp.${data.aws_region.current.name}.amazonaws.com"]
}

resource "aws_ses_receipt_rule_set" "inbound" {
  rule_set_name = "inbound"
}

resource "aws_ses_receipt_rule" "inbound" {
  name          = var.domain
  rule_set_name = aws_ses_receipt_rule_set.inbound.rule_set_name
  enabled       = true
  scan_enabled  = true

  s3_action {
    position    = 1
    bucket_name = aws_s3_bucket.inbox.id
  }

  sns_action {
    encoding  = "UTF-8"
    position  = 2
    topic_arn = aws_sns_topic.inbox.arn
  }
}
