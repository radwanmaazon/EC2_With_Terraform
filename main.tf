module "ec2_module" {
  source         = "./ec2_module/"
  project_name   = var.project_name
  region         = var.region
  cidr           = var.cidr_block

  security_groups_egress  = var.security_groups_egress
  security_groups_ingress = var.security_groups_ingress
  instance_type           = var.instance_type

  public_subnet_id  =var.public_subnet_id
  key_pair_name     = var.key_pair_name
  private_key_path  = var.private_key_path
}