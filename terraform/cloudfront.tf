locals {
  s3_origin_id = "marsha-plugins-origin"
}

# Create an origin access identity that will allow CloudFront to access S3
resource "aws_cloudfront_origin_access_identity" "marsha_plugins_oai" {
  comment = "Marsha origin for the ${terraform.workspace} environment"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.marsha_plugins.bucket_regional_domain_name}"
    origin_id   = "${local.s3_origin_id}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.marsha_plugins_oai.cloudfront_access_identity_path}"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true

  # Destination bucket: allow public access by default
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${local.s3_origin_id}"

    forwarded_values {
      query_string = false
      headers = ["Access-Control-Request-Headers", "Access-Control-Request-Method", "Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "${lookup(var.cloudfront_price_class, terraform.workspace, "PriceClass_100")}"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags {
    Environment = "${terraform.workspace}"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
