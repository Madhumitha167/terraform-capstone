output "webserver-ips" {
    value = aws_instance.web_servers[*].public_ip
}
