# ==============================================================================
# CREATING RESORCE FOR AWS_S3 BUCKET
# ==============================================================================
resource "aws_s3_bucket" "nuel-bucket" {
  bucket = var.bucket_name

  tags = local.merged_tags
}
# ==============================================================================
# CREATING RESORCE FOR AWS_S3_BUCKET_PUBLIC_ACCESS_BLOCK
# ==============================================================================

resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.nuel-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ==============================================================================
# CREATING RESORCE FOR AWS_S3_BUCKET POLICY
# ==============================================================================
resource "aws_s3_bucket_policy" "policy" {
  depends_on = [aws_s3_bucket_public_access_block.access_block]
  bucket = aws_s3_bucket.nuel-bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipal"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.nuel-bucket.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.s3_distribution.arn
          }
        }
      }
    ]
  })
}
# ==============================================================================
# CREATING RESORCE FOR AWS_S3_BUCKET_OBJECT
# ==============================================================================
resource "aws_s3_object" "website-files" {
  for_each = fileset("${path.module}/www", "**/*")
  bucket = aws_s3_bucket.nuel-bucket.id
  key = each.value
  source = "${path.module}/www/${each.value}"
  etag   = filemd5("${path.module}/www/${each.value}")
  content_type = lookup({
    "html" = "text/html",
    "css"  = "text/css",
    "js"   = "application/javascript",
    "json" = "application/json",
    "png"  = "image/png",
    "jpg"  = "image/jpeg",
    "jpeg" = "image/jpeg",
    "gif"  = "image/gif",
    "svg"  = "image/svg+xml",
    "ico"  = "image/x-icon",
    "txt"  = "text/plain"
  }, split(".", each.value)[length(split(".", each.value)) - 1], "application/octet-stream")
}


# ==============================================================================
# CREATING RESORCE FOR CLOUDFRONT DISTRIBUTION
# ==============================================================================
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.nuel-bucket.bucket_regional_domain_name
    origin_id                = "S3-${aws_s3_bucket.nuel-bucket.id}"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.nuel-bucket.id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# ==============================================================================
# CREATING RESORCE FOR ORIGIN ACCESS CONTROL FOR CLOUDFRONT
# ==============================================================================
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "oac-${var.bucket_name}"
  description                       = "OAC for static website"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}