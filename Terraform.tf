provider "aws" {
  region  = "us-east-1"
}

# Criação do Jenkins Server

resource "aws_instance" "jenkins_server" {
  ami                         = "ami-02fe94dee086c0c37"
  instance_type               = "t3.medium"
  associate_public_ip_address = "true"
  source_dest_check           = "false"
  monitoring                  = false
  key_name                    = "jenkins_hands_on"
  vpc_security_group_ids      = [aws_security_group.jenkins_server.id, ]

  root_block_device {
    volume_size = "50"
    volume_type = "gp2"
  }

  lifecycle {
    ignore_changes = [user_data]
  }

  tags = {
    Name               = "Jenkins-Server"
  }
}

resource "aws_security_group" "jenkins_server" {
  name_prefix = "jenkins_server_"
  vpc_id      = "vpc-0b7aaa4fa34ae2ab8"

  ingress {
    description = "Accesso ao SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0",]
  }

  ingress {
    description = "Accesso ao SSH"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0",]
  }

  egress {
    description = "Accesso full para todos do security group"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0",]
  }

  tags = {
    Name        = "jenkins_server"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "jenkins_server" {
  zone_id = "Z04634481AEJ18O89P97W"
  name    = "jenkins.lynxnetwork.com.br"
  type    = "A"
  ttl     = "5"
  records = [aws_instance.jenkins_server.public_ip]
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins_server.public_ip
  
}

# Criação do WebServer

resource "aws_instance" "webserver" {
  ami                         = "ami-02fe94dee086c0c37"
  instance_type               = "t3.small"
  associate_public_ip_address = "true"
  source_dest_check           = "false"
  monitoring                  = false
  key_name                    = "jenkins_hands_on"
  vpc_security_group_ids      = [aws_security_group.webserver.id, ]

  root_block_device {
    volume_size = "50"
    volume_type = "gp2"
  }

  lifecycle {
    ignore_changes = [user_data]
  }

  tags = {
    Name               = "webserver"
  }
}

resource "aws_security_group" "webserver" {
  name_prefix = "webserver_"
  vpc_id      = "vpc-0b7aaa4fa34ae2ab8"

  ingress {
    description = "Accesso ao SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0",]
  }

  ingress {
    description = "Accesso ao Nginx"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0",]
  }

  ingress {
    description = "Accesso ao WebSite"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0",]
  }

  egress {
    description = "Accesso full para todos do security group"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0",]
  }

  tags = {
    Name        = "webserver"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "website" {
  zone_id = "Z04634481AEJ18O89P97W"
  name    = "website.lynxnetwork.com.br"
  type    = "A"
  ttl     = "5"
  records = [aws_instance.webserver.public_ip]
}

output "webserver_public_ip" {
  value = aws_instance.webserver.public_ip
  
}