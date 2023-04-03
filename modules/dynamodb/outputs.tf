output "table_name" {
  value       = aws_dynamodb_table.this.name
  description = "dynamodb name"
}

output "table_arn" {
  value       = aws_dynamodb_table.this.arn
  description = "dynamodb arn"
}