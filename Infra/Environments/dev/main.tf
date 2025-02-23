module "s3" {
  source              = "../../Modules/S3"
  source_bucket_name  = var.source_bucket_name
  target_bucket_name  = var.target_bucket_name
}

module "iam" {
  source            = "../../Modules/IAM"
  source_bucket_arn = module.s3.source_bucket_arn
  target_bucket_arn = module.s3.target_bucket_arn
  source_bucket_name = var.source_bucket_name
  target_bucket_name = var.target_bucket_name
}

module "lambda" {
  source                   = "../../Modules/LAMBDA"
  lambda_function_name      = var.lambda_function_name
  lambda_execution_role_arn = module.iam.lambda_execution_role_arn
  source_bucket_name        = var.source_bucket_name
  target_bucket_name        = var.target_bucket_name
  lambda_source_file        = var.lambda_source_file
  lambda_output_path        = var.lambda_output_path
}

module "api_gateway" {
  source               = "../../Modules/APIGATEWAY"
  api_name             = "greeting_api"
  lambda_function_name = module.lambda.function_name
  lambda_function_arn  = module.lambda.function_arn
  stage_name           = "prod"
  lambda_execution_role_name  = module.iam.lambda_execution_role_name
}