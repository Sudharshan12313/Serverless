variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
  default     = "greeting_api"
}

variable "lambda_function_name" {
  description = "Lambda function name to integrate with API Gateway"
  type        = string
}

variable "lambda_function_arn" {
  description = "Lambda function ARN"
  type        = string
}

variable "stage_name" {
  description = "Deployment stage name"
  type        = string
  default     = "prod"
}

variable "lambda_execution_role_name" {
  description = "Lambda execute role"
  type        = string
}
