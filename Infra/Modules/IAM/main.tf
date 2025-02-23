resource "aws_iam_role" "lambda_execution_role" {
  name = "terraform-lambda-greetings-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_s3_access_policy" {
  name        = "terraform-lambda-s3-access-policy"
  description = "Grants access to source and destination buckets"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:GetObject"],
        Effect   = "Allow",
        Resource = [
          "${var.source_bucket_arn}/*"
        ]
      },
      {
        Action   = ["s3:PutObject"],
        Effect   = "Allow",
        Resource = [
          "${var.target_bucket_arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_s3_policy" {
  name        = "LambdaS3AccessPolicy"
  description = "IAM policy for Lambda to access S3 buckets"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:ListBucket"
        Resource = "arn:aws:s3:::${var.source_bucket_name}"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject"]
        Resource = "arn:aws:s3:::${var.source_bucket_name}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_s3_attach" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_s3_policy.arn
}


resource "aws_iam_role_policy_attachment" "s3_full_access_attachment" {
  policy_arn = aws_iam_policy.lambda_s3_access_policy.arn
  role       = aws_iam_role.lambda_execution_role.name
}

resource "aws_iam_role_policy_attachment" "lambda_xray_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
  role       = aws_iam_role.lambda_execution_role.name
}

resource "aws_iam_policy" "lambda_cloudwatch_policy" {
  name        = "LambdaCloudWatchPolicy"
  description = "Allows Lambda to write logs to CloudWatch."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
        Effect   = "Allow",
        Resource = "*" 
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_cloudwatch_attach" {
  policy_arn = aws_iam_policy.lambda_cloudwatch_policy.arn
  role       = aws_iam_role.lambda_execution_role.name
}