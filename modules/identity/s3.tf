resource "aws_s3_bucket" "inbox" {
  bucket = "inbox-${var.domain}"
}

resource "aws_s3_bucket_acl" "private" {
  bucket = aws_s3_bucket.inbox.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "private" {
  bucket              = aws_s3_bucket.inbox.id
  block_public_acls   = true
  block_public_policy = true
}

data "aws_iam_policy_document" "s3" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ses.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.inbox.arn}/*"]

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

resource "aws_s3_bucket_policy" "inbox" {
  bucket = aws_s3_bucket.inbox.id
  policy = data.aws_iam_policy_document.s3.json
}