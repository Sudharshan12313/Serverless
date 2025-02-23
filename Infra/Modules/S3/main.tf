resource "aws_s3_bucket" "source_bucket" {
  bucket = var.source_bucket_name
}

resource "aws_s3_bucket_ownership_controls" "source_bucket_ownership_controls" {
  bucket = aws_s3_bucket.source_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "source_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.source_bucket_ownership_controls]
  bucket     = aws_s3_bucket.source_bucket.id
  acl        = "private"
}

resource "aws_s3_bucket" "target_bucket" {
  bucket = var.target_bucket_name
}

resource "aws_s3_bucket_ownership_controls" "target_bucket_ownership_controls" {
  bucket = aws_s3_bucket.target_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "target_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.target_bucket_ownership_controls]
  bucket     = aws_s3_bucket.target_bucket.id
  acl        = "private"
}
