resource "aws_sns_topic" "inbox" {
  name = replace(var.domain, ".", "_")
}

data "aws_iam_policy_document" "sns" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ses.amazonaws.com"]
    }
    actions   = ["SNS:Publish"]
    resources = [aws_sns_topic.inbox.arn]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = ["098938559886"]
    }

    condition {
      test     = "StringLike"
      variable = "AWS:SourceArn"
      values   = ["arn:aws:ses:*"]
    }
  }
}

resource "aws_sns_topic_policy" "inbox" {
  arn    = aws_sns_topic.inbox.arn
  policy = data.aws_iam_policy_document.sns.json
}


resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  for_each  = toset(var.forwarding_emails)
  topic_arn = aws_sns_topic.inbox.arn
  protocol  = "email"
  endpoint  = each.value
}