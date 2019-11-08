# Create source S3 Bucket for uploaded videos to be converted
resource "aws_s3_bucket" "marsha_plugins" {
  bucket = "${terraform.workspace}-marsha-plugins"
  acl    = "private"
  region = "${var.aws_region}"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["POST"]
    allowed_origins = ["*"]
    max_age_seconds = 3600
  }

  tags {
    Name        = "marsha-plugins"
    Environment = "${terraform.workspace}"
  }
}

# Grant user access to the plugins bucket
resource "aws_s3_bucket_policy" "marsha_plugins_bucket_policy" {
  bucket = "${aws_s3_bucket.marsha_plugins.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Cloudfront",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_cloudfront_origin_access_identity.marsha_plugins_oai.iam_arn}"
      },
      "Action": "s3:GetObject",
      "Resource": "${aws_s3_bucket.marsha_plugins.arn}/*"
    }
  ]
}
EOF
}

# copy adways script to plugins bucket
resource "aws_s3_bucket_object" "object" {
  bucket        = "${aws_s3_bucket.marsha_plugins.id}"
  key           = "static/js/adways.js"
  source        = "/src/static/js/adways.js"
  content_type  = "application/javascript"
  etag          = "${filemd5("/src/static/js/adways.js")}"
}
