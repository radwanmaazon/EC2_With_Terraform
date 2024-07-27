resource "aws_instance" "private_instance" {
  ami               = data.aws_ami.latest_amazon_linux.id
  instance_type     = var.instance_type
  subnet_id         = aws_subnet.private_subnets[0].id
  key_name          = var.key_pair_name
  security_groups   = [aws_security_group.allow_tls_SG.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "${var.project_name}-private_ec2"
  }

}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]  
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]  
}


