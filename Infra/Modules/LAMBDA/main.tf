data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = var.lambda_source_file
  output_path = var.lambda_output_path
}

resource "aws_lambda_function" "greeting_lambda" {
  function_name = var.lambda_function_name

  handler     = "index.handler"
  runtime     = "nodejs18.x"
  memory_size = 256
  role        = var.lambda_execution_role_arn

  environment {
    variables = {
      SRC_BUCKET = var.source_bucket_name
      DST_BUCKET = var.target_bucket_name
    }
  }

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  tracing_config {
    mode = "Active"
  }
}
