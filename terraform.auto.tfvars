region          = "us-east-1"
project_name    = "VAT-09"
cidr_block      = ["172.31.100.0/24", "172.31.101.0/24", "172.31.102.0/24", "172.31.103.0/24", "172.31.104.0/24", "172.31.105.0/24" ]


# instance_ami    = "ami-0b72821e2f351e396"
instance_type   = "t2.micro"
security_groups_ingress = [{
        from_port   = 22
        to_port     = 22
        protocol    = "TCP"
        cidr_blocks = "0.0.0.0/0"
    }
    ]
public_subnet_id = "subnet-0d6caea9515d706bf"
security_groups_egress = [{
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = "0.0.0.0/0"
    },
    ]

key_pair_name   = "radwan-key"
private_key_path= "~/Downloads/radwan-key.pem"