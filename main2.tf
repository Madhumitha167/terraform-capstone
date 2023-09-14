data "aws_security_group" "madhu_sg" {
  name = "terr-securitygroup"  
}

data "aws_subnet" "madhu_subnet1" {
  id = "aws_subnet.madhu_subnet1.id"  # Replace with your actual subnet ID
}

variable "subnet_id" {}

resource "aws_launch_template" "madhu_lt" {
  name = "terr-launchtemplate"
  instance_type = "t2.micro"
  image_id = "ami-091d5f8b86b4cefbe"
  vpc_security_group_ids = aws_security_group.madhu_sg.id
  subnet_id = aws_subnet.madhu_subnet1.id

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 8
      delete_on_termination = true
    }
  }
   
}
