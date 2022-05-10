resource "aws_sns_topic" "inbox" {
  name = replace(replace(var.email, "@", "_AT_"), ".", "_")
}

data "aws_iam_policy_document" "ses" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ses.amazonaws.com"]
    }

    actions   = ["SNS:Publish"]
    resources = [aws_sns_topic.inbox.arn]
  }
}

resource "aws_sns_topic_policy" "inbox" {
  arn    = aws_sns_topic.inbox.arn
  policy = data.aws_iam_policy_document.ses.json
}

resource "aws_ses_receipt_rule" "inbox" {
  name          = replace(var.email, "@", "_AT_")
  rule_set_name = var.rule_set_name
  recipients    = [var.email]
  enabled       = true
  scan_enabled  = true

  add_header_action {
    position     = 1
    header_name  = "Custom-Header"
    header_value = "Added by SES"
  }

  sns_action {
    position  = 2
    encoding  = "UTF-8"
    topic_arn = aws_sns_topic.inbox.arn
  }
}

resource "aws_sns_topic_subscription" "forward" {
  for_each  = toset(var.forwarding_emails)
  topic_arn = aws_sns_topic.inbox.arn
  protocol  = "email"
  endpoint  = each.value
}