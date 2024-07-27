resource "aws_instance" "bastion_host" {
  ami               = data.aws_ami.latest_amazon_linux.id
  instance_type     = var.instance_type
  subnet_id         = var.public_subnet_id
  key_name          = var.key_pair_name
  associate_public_ip_address = true  # Assign a public IP to the instance for external access

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y amazon-ssm-agent
    systemctl enable amazon-ssm-agent
    systemctl start amazon-ssm-agent

    # Install necessary packages
    yum install -y openssh

    # Set up SSH tunneling
    ssh -i /home/ec2-user/.ssh/id_rsa -N -L 2222:${aws_instance.private_instance.private_ip}:22 ec2-user@localhost &
  EOF

  tags = {
    Name = "${var.project_name}-bastion-host"
  }


  security_groups = [aws_security_group.allow_tls_SG.id]
}