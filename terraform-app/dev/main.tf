terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "us-east-1"
}
module "myvpc" {
  source = "../modules/vpc"
  vpc_cidr = "192.168.0.0/16"
  tenancy = "default"
  vpc_id = "${module.myvpc.vpc_id}"
  subnet_cidr = "192.168.0.0/24"
}
module "myec2" {
source = "../modules/ec2"  
ec2_count = 1
ami_id = "${var.ami_id}"  
instance_type = "t2.micro"
subnet_id = "${module.myvpc.subnet_id}"
}