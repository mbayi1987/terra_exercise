#Get Linux AMI ID using SSM Parameter endpoint 
data "aws_ssm_parameter" "linuxAmi" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

#Create key-pair for logging into EC2 
resource "aws_key_pair" "login" {
  key_name   = "secret"
  public_key = file("~/.ssh/id_rsa.pub")
}

#Create EC2 instance
resource "aws_instance" "webserver-instance" {
  ami                         = data.aws_ssm_parameter.linuxAmi.value
  instance_type               = var.instance-type
  key_name                    = aws_key_pair.login.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web-sg.id]
  subnet_id                   = aws_subnet.subnet_1.id

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install docker -y",
      "sudo systemctl start docker && sudo systemctl enable docker",
      "sudo docker run -itd --name test nginx"
    ]
}


    connection {
        type = "ssh"
        host = self.public_ip
        user = "ec2-user"
        private_key = file("~/.ssh/id_rsa")
        
      }
  
  tags = {
    Name = "my-server"
  }
}