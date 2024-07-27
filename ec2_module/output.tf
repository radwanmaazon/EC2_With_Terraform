output "ec2_instance_id" {
  value = aws_instance.private_instance.id
}

output "ec2_instance_private_ip" {
  value = aws_instance.private_instance.private_ip
}

output "security_group_name" {
  value = aws_security_group.allow_tls_SG.name
}

output "security_group_id" {
  value = aws_security_group.allow_tls_SG.id
}
