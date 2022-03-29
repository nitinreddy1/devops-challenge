resource "aws_instance" "web_host" {
  ami                    = "ami-07ebfd5b3428b6f4d"
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg_web.id]
  subnet_id              = aws_subnet.public[0].id
  iam_instance_profile   = aws_iam_instance_profile.ec2_role_profile.name
  associate_public_ip_address = true

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install software-properties-common apt-transport-https ca-certificates curl -y
                sudo add-apt-repository ppa:deadsnakes/ppa
                sudo apt update -y
                sudo apt install python3.8 -y
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
                sudo apt update -y
                sudo apt install git docker-ce -y
                sudo usermod -aG docker ubuntu
                newgrp docker
                git clone https://github.com/nitinreddy1/devops-challenge.git
                cd devops-challenge/webapp
                docker build -t webapp:latest .
                docker run -p 80:80 -d webapp:latest
                EOF
  tags = {
    Name = "web host"
  }
}
