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

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "greetings-lambda-function"
}

variable "lambda_source_file" {
  description = "Path to the Lambda source file"
  type        = string
  default     = "index.mjs"
}

variable "lambda_output_path" {
  description = "Output path for the Lambda zip file"
  type        = string
  default     = "lambda.zip"
}


/*variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
  default     = "greeting_api"
}*/

/*variable "stage_name" {
  description = "Deployment stage name"
  type        = string
  default     = "prod"
}*/
