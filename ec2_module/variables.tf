# Environment Variables
variable "region" {}
variable "project_name" {}

variable "cidr" {
    type =list 
    default = ["", "", "", "", "", ""]
}

# Instance Variables
variable "instance_type" {
  default = "t2.micro"
}

variable "public_subnet_id" {
  type = string
  default = ""
}

variable "security_groups_ingress" {
    type =list(object({
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = string
    }))
    default = [{
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
    },{
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }
    ]
}

variable "security_groups_egress" {
    type = list(object({
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = string
    }))
}
variable "key_pair_name" {
  type        = string
  default = "radwan-key"
}
variable "private_key_path" {
  type        = string
  default     = "~/Downloads/radwan-key.pem"
}