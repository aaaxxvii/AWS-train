output "alb_dns_name" {
  value = "http://${aws_lb.main.dns_name}/v1/chat"
  description = "API Endpoint URL"
}