variable "source_bucket_arn" {
  description = "ARN of the source S3 bucket"
  type        = string
}

variable "target_bucket_arn" {
  description = "ARN of the target S3 bucket"
  type        = string
}

variable "source_bucket_name" {
  description = "Name of the source S3 bucket"
  type        = string
  default     = "source-bucket-test"
}

variable "target_bucket_name" {
  description = "Name of the target S3 bucket"
  type        = string
  default     = "target-bucket-test"
}
