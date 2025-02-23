<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | ../../Modules/APIGATEWAY | n/a |
| <a name="module_iam"></a> [iam](#module\_iam) | ../../Modules/IAM | n/a |
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ../../Modules/LAMBDA | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | ../../Modules/S3 | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | Name of Lambda function | `string` | `"greetings-lambda-function"` | no |
| <a name="input_lambda_output_path"></a> [lambda\_output\_path](#input\_lambda\_output\_path) | Output path for the Lambda zip file | `string` | `"lambda.zip"` | no |
| <a name="input_lambda_source_file"></a> [lambda\_source\_file](#input\_lambda\_source\_file) | Path to the Lambda source file | `string` | `"index.mjs"` | no |
| <a name="input_source_bucket_name"></a> [source\_bucket\_name](#input\_source\_bucket\_name) | Name of the source S3 bucket | `string` | `"source-bucket-test"` | no |
| <a name="input_target_bucket_name"></a> [target\_bucket\_name](#input\_target\_bucket\_name) | Name of the target S3 bucket | `string` | `"target-bucket-test"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->