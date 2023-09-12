# vpc
resource "aws_vpc" "madhu_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "madhu-terr-vpc"
  }
}
# subnet 1 (public)
resource "aws_subnet" "madhu_subnet1" {
  vpc_id = aws_vpc.madhu_vpc.id
  cidr_block = var.subnet1_cidr
  availability_zone_id = var.subnet1_availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "terr-subnet1"
  }
}
# subnet 2(public) change it to private
resource "aws_subnet" "madhu_subnet2" {
  vpc_id = aws_vpc.madhu_vpc.id
  cidr_block = var.subnet2_cidr
  availability_zone_id = var.subnet2_availability_zone
  map_public_ip_on_launch = false
  tags = {
    Name = "terr-subnet2"
  }

}

# internet gateway
resource "aws_internet_gateway" "madhu_igw" {
  vpc_id = aws_vpc.madhu_vpc.id
  tags = {
    Name = "terr-igw"
  }
}


# route table 1 
resource "aws_route_table" "madhu_rt_public" {
  vpc_id = aws_vpc.madhu_vpc.id
  tags = {
    Name = "terr-rt1"
  }
}
#route table 2 
resource "aws_route_table" "madhu_rt_private" {
  vpc_id = aws_vpc.madhu_vpc.id
  tags = {
    Name = "terr-rt2"
  }
}
# Associating route table 1 with subnet 1 
resource "aws_route_table_association" "madhu_subnet_rt_association1" {
  subnet_id = aws_subnet.madhu_subnet1.id
  route_table_id = aws_route_table.madhu_rt_public.id
}

# Associating route table 2 with subnet 2 
resource "aws_route_table_association" "madhu_subnet_rt_association2" {
  subnet_id = aws_subnet.madhu_subnet2.id
  route_table_id = aws_route_table.madhu_rt_private.id
}

# Adding the internet gateway route to route table 1
resource "aws_route" "madhu_route1" {
  route_table_id = aws_route_table.madhu_rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.madhu_igw.id
}

# NAT Gateway
resource "aws_nat_gateway" "madhu_nat_gateway" {
  allocation_id = aws_eip.madhu_eip.id
  subnet_id     = aws_subnet.madhu_subnet1.id # Replace with your public subnet ID
}

# Elastic IP for NAT Gateway
resource "aws_eip" "madhu_eip" {
  vpc = true
}

# Modify the route table associated with your private subnet to route traffic through the NAT Gateway
resource "aws_route" "madhu_private_subnet_route" {
  route_table_id         = aws_route_table.madhu_rt_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.madhu_nat_gateway.id
}

# creating a security group
resource "aws_security_group" "madhu_sg" {
  vpc_id = aws_vpc.madhu_vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 instances
resource "aws_instance" "aws_instances" {
  count = var.instance_count

  ami           = var.ami_id 
  instance_type = var.instance_type     
  subnet_id     = aws_subnet.madhu_subnet1.id
  key_name      = "ssh-terraform-key"
  security_groups = [aws_security_group.madhu_sg.id]
  tags = {
    Name = "terr-instance-${count.index + 1}"
  }
}

#s3 bucket

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket_prefix = var.s3_prefix
  acl = var.acl
}
