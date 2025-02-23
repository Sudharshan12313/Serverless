output "greeting_api_endpoint" {
  description = "API Gateway endpoint URL"
  value       = "${aws_api_gateway_deployment.greeting_api_deployment.invoke_url}/greet"
}
