# resource "aws_instance" "public_instance" {
#     ami               = data.aws_ami.latest_amazon_linux.id
#     instance_type     = var.instance_type
#     subnet_id         = var.public_subnet_id
#     key_name          = var.key_pair_name
#     security_groups   = [aws_security_group.allow_tls_SG.id]
#     iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
#     tags = {
#         Name = "${var.project_name}-public_ec2"
#     }
# }


