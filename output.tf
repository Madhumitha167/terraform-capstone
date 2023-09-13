output "instance_ips" {
  value = aws_instance.web_servers.*.public_ip
}
