output "public_ip1" {
  description = "Public IP address of the EC2 instance Webserver1"
  value       = aws_instance.webserver1.public_ip
}

output "public_ip2" {
  description = "Public IP address of the EC2 instance Webserver2"
  value       = aws_instance.webserver2.public_ip
}