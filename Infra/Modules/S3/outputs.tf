output "source_bucket_name" {
  description = "The name of the source S3 bucket"
  value       = aws_s3_bucket.source_bucket.id
}

output "source_bucket_arn" {
  description = "The ARN of the source S3 bucket"
  value       = aws_s3_bucket.source_bucket.arn
}

output "target_bucket_name" {
  description = "The name of the target S3 bucket"
  value       = aws_s3_bucket.target_bucket.id
}

output "target_bucket_arn" {
  description = "The ARN of the target S3 bucket"
  value       = aws_s3_bucket.target_bucket.arn
}
