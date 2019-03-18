#resource

#vpc
resource "aws_vpc" "admin-mngt-infra" {
    cidr_block = "${var.vpc-cidr}"
    enable_dns_hostnames = "true"
    tags{
      Name = "${var.vpc-name}"
    }
}

#igw
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.admin-mngt-infra.id}"
}

#subnets
resource "aws_subnet" "Admin-Public" {
  cidr_block = "${var.Admin-Public-subnet-cidr}"
  vpc_id = "${aws_vpc.admin-mngt-infra.id}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.Admin-Public-az}"
  tags{
    Name = "${var.Pub-subnet-Name}"
  }
}

resource "aws_subnet" "Admin-Private" {
  cidr_block = "${var.Admin-Private-subnet-cidr}"
  vpc_id = "${aws_vpc.admin-mngt-infra.id}"
  map_public_ip_on_launch = "false"
  availability_zone = "${var.Admin-Private-az}"
  tags{
    Name = "${var.Pvt-subnet-Name}"
  }
}


#nat gateway
resource "aws_eip" "Admin-nat-eip" {
  vpc = true
}

resource "aws_nat_gateway" "Admin-nat" {
  allocation_id = "${aws_eip.Admin-nat-eip.id}"
  subnet_id     = "${aws_subnet.Admin-Public.id}"
}

#routing

resource "aws_route_table" "admin-public-rtb" {
  vpc_id = "${aws_vpc.admin-mngt-infra.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

resource "aws_route_table" "private-rtb-1" {
  vpc_id = "${aws_vpc.admin-mngt-infra.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.Admin-nat.id}"
  }
}

#routetable association

resource "aws_route_table_association" "rta-admin-public-1" {
  subnet_id = "${aws_subnet.Admin-Public.id}"
  route_table_id = "${aws_route_table.admin-public-rtb.id}"
}

resource "aws_route_table_association" "rta-private-1" {
  subnet_id = "${aws_subnet.Admin-Private.id}"
  route_table_id = "${aws_route_table.private-rtb-1.id}"
}



#VPC FlowLogs
resource "aws_flow_log" "VPC-Flowlogs" {
  log_destination      = "${var.flowlogBucketARN}"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = "${aws_vpc.admin-mngt-infra.id}"
}

#security groups

resource "aws_security_group" "Admin-Public-sg" {
  name = "${var.Admin-Public-sg-Name}"
  description = "Admin Public group"
  vpc_id = "${aws_vpc.admin-mngt-infra.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["78.138.0.0/16","78.150.0.0/16","44.215.49.238/32"]
  }
  ingress {
    from_port = 54321
    to_port = 54321
    protocol = "tcp"
    cidr_blocks = ["78.138.0.0/16","78.150.0.0/16"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags {
    Name = "${var.Admin-Public-sg-Name}"
  }
}

resource "aws_security_group" "Admin-Private-sg" {
  name = "${var.Admin-Private-sg-Name}"
  vpc_id = "${aws_vpc.admin-mngt-infra.id}"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = ["${aws_security_group.Admin-Public-sg.id}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}






