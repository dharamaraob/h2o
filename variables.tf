#Variables

variable "bucket" {
  description = "AWS S3 Bucket"
  default     = "vz-vpc-infra"
}
variable "key" {
  description = "AWS S3 key"
  default     = "test-VPC/terraform.tfstate"
}

variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-060f1e7b74b27ee67"
    eu-west-1 = "ami-844e0bf7"
  }
}
variable "ins_type" { default="p3.2xlarge" }

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}

variable "ACCOUNT_ID"{}
variable "ROLE_Name"{}
variable "vpc-region"{}
variable "vpc-cidr"{}
variable "vpc-name"{}
variable "Pub-subnet-Name"{}
variable "Pvt-subnet-Name"{}
variable "Admin-Public-subnet-cidr"{}
variable "Admin-Public-az"{}
variable "Admin-Private-subnet-cidr"{}
variable "Admin-Private-az"{}
variable "flowlogBucketARN"{}
variable "Admin-Public-sg-Name"{}
variable "Admin-Private-sg-Name"{}