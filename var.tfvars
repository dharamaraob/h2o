ACCOUNT_ID = "xxxxxxxx"
#provider

#VPC
vpc-region = "us-west-2"
vpc-cidr = "172.22.0.0/16"
vpc-name = "Test-VPC"

#subnet


#public-subnet
Admin-Public-subnet-cidr = "172.22.1.0/24"
Admin-Public-az = "us-west-2a"
Pub-subnet-Name = "Test-Public-Subnet"


#private-subnet
Admin-Private-subnet-cidr = "172.22.2.0/24"
Admin-Private-az = "us-west-2b"
Pvt-subnet-Name = "Test-Private-Subnet"

#Security group
Admin-Public-sg-Name = "Test-Public-sg"
Admin-Private-sg-Name = "Test-Private-sg"

flowlogBucketARN = "arn:aws:s3:::tcvnp-vpcflowlogs" # Change your bucket
