# Create an IAM Role for API Gateway
resource "aws_iam_role" "api_gateway_greeting_queue_role" {
  name = "api_gateway_greeting_queue_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "apigateway.amazonaws.com"
        },
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
}

# Create a policy allowing API Gateway to send messages to the SQS queue
resource "aws_iam_role_policy" "api_gateway_greeting_queue_role_policy" {
  name = "api_gateway_greeting_queue_role_policy"
  role = aws_iam_role.api_gateway_greeting_queue_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "sqs:SendMessage",
        Effect   = "Allow",
        Resource = aws_sqs_queue.greeting_queue.arn
      }
    ]
  })
}


# Create a REST API Gateway
resource "aws_api_gateway_rest_api" "greeting_api" {
  name        = var.api_name
  description = "API for invoking the Greeting Lambda Function"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# Create an API Resource
resource "aws_api_gateway_resource" "greet_resource" {
  rest_api_id = aws_api_gateway_rest_api.greeting_api.id
  parent_id   = aws_api_gateway_rest_api.greeting_api.root_resource_id
  path_part   = "greet"
}

# Create an API Method
resource "aws_api_gateway_method" "greet_method" {
  rest_api_id   = aws_api_gateway_rest_api.greeting_api.id
  resource_id   = aws_api_gateway_resource.greet_resource.id
  http_method   = "POST"
  authorization = "NONE"
}


# Fetch the AWS region dynamically
data "aws_region" "current" {}


resource "aws_sqs_queue" "greeting_queue" {
  name                    = "greetings_queue"
  sqs_managed_sse_enabled = true
}


data "aws_caller_identity" "current" {}

# Create an integration that sends incoming request body as a message to SQS
resource "aws_api_gateway_integration" "greet_method_integration" {
  rest_api_id             = aws_api_gateway_rest_api.greeting_api.id
  resource_id             = aws_api_gateway_resource.greet_resource.id
  http_method             = aws_api_gateway_method.greet_method.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:sqs:path/${data.aws_caller_identity.current.account_id}/${aws_sqs_queue.greeting_queue.name}"
  request_parameters = {
    "integration.request.header.Content-Type" = "'application/x-www-form-urlencoded'"
  }
  request_templates = {
    "application/json" = "Action=SendMessage&MessageBody=$input.body"
  }
  credentials = aws_iam_role.api_gateway_greeting_queue_role.arn
}

resource "aws_api_gateway_integration_response" "integration_response_200" {
  rest_api_id = aws_api_gateway_rest_api.greeting_api.id
  resource_id = aws_api_gateway_resource.greet_resource.id
  http_method = aws_api_gateway_method.greet_method.http_method
  status_code = 200
  selection_pattern = "^2[0-9][0-9]" # Any 2xx response

  response_templates = {
    "application/json" = "{\"status\": \"success\"}"
  }

  depends_on = [aws_api_gateway_integration.greet_method_integration]
}

resource "aws_api_gateway_method_response" "method_response_200" {
  rest_api_id = aws_api_gateway_rest_api.greeting_api.id
  resource_id = aws_api_gateway_resource.greet_resource.id
  http_method = aws_api_gateway_method.greet_method.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }
}

# Create a Lambda event-source mapping to enable Lambda to poll from the queue
resource "aws_lambda_event_source_mapping" "greeting_sqs_mapping" {
  event_source_arn = aws_sqs_queue.greeting_queue.arn
  function_name    = var.lambda_function_name
  batch_size       = 1

  depends_on = [aws_iam_role_policy_attachment.greeting_lambda_sqs_policy_attachment ]
}

# Create a new API Gateway deployment
resource "aws_api_gateway_deployment" "greeting_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.greeting_api.id
  stage_name  = var.stage_name

  triggers = {
    redeployment = sha256(jsonencode(aws_api_gateway_rest_api.greeting_api.body))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_method.greet_method,
    aws_api_gateway_integration.greet_lambda_integration
  ]
}
