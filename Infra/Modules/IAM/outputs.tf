output "lambda_execution_role_name" {
  description = "The name of the IAM role for Lambda execution"
  value       = aws_iam_role.lambda_execution_role.name
}

output "lambda_execution_role_arn" {
  description = "The ARN of the IAM role for Lambda execution"
  value       = aws_iam_role.lambda_execution_role.arn
}

output "lambda_s3_access_policy_arn" {
  description = "The ARN of the IAM policy attached to Lambda for S3 access"
  value       = aws_iam_policy.lambda_s3_access_policy.arn
}
