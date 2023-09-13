#vpc cidr

variable "vpc_cidr" {
    description = "CIDR range of vpc"
    type = string
    default = "192.168.1.0/24"
}

#subnet1 cidr

variable "subnet1_cidr" {
    description = "CIDR range of subnet 1"
    type = string
    default = "192.168.1.0/26"
}

#subnet1 availability zone 

variable "subnet1_availability_zone" {
    description = "Availability zone for subnet 1 " 
    type = string
    default ="apse1-az1"
}

#subnet2 cidr

variable "subnet2_cidr" {
    description = "CIDR range of subnet 2"
    type = string
    default = "192.168.1.64/26"

}

#subnet2 availability zone 

variable "subnet2_availability_zone" {
    description = "Availability zone for subnet 2 " 
    type = string
    default ="apse1-az2"
}

#subnet3 cidr

variable "subnet3_cidr" {
    description = "CIDR range of subnet 2"
    type = string
    default = "192.168.1.128/26"

}

#subnet3 availability zone 

variable "subnet3_availability_zone" {
    description = "Availability zone for subnet 2 " 
    type = string
    default ="apse1-az3"
}

# instance count

variable "instance_count" {
    description = "Number of instances required"
    type = number
    default = 1
}

#instance type 

variable "instance_type" {
    description = "type of instance"
    type = string
    default = "t2.micro"
}

#ami of instances

variable "ami_id" {
    description = "ami id of instance"
    type = string
    default = "ami-0df7a207adb9748c7"
}

#bucket prefix for s3
variable "s3_prefix" {
    description = "It creates a s3 bucket with this prefix and random numbers"
    type = string
    default = "terr-s3-"
}

variable "acl" {
    type = string
    default = "private"
}





