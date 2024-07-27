output "ec2_private_instance_id" {
  value = module.ec2_module.ec2_instance_id
}

output "ec2_private_instance_private_ip" {
  value = module.ec2_module.ec2_instance_private_ip
}

output "security_group_name" {
  value = module.ec2_module.security_group_name
}

output "security_group_id" {
  value = module.ec2_module.security_group_id
}