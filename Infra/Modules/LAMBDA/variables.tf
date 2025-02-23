variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_execution_role_arn" {
  description = "IAM role ARN for Lambda execution"
  type        = string
}

variable "source_bucket_name" {
  description = "Name of the source bucket"
  type        = string
}

variable "target_bucket_name" {
  description = "Name of the target bucket"
  type        = string
}

variable "lambda_source_file" {
  description = "Lambda function source file"
  type        = string
}

variable "lambda_output_path" {
  description = "Lambda function zip file output path"
  type        = string
}
