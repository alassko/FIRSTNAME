provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

resource "aws_instance" "web_server" {
  ami             = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI
  instance_type   = "t2.micro"  # Change to your desired instance type
  key_name        = "your_key_pair_name"  # Change to your key pair name
  security_groups = ["web_server_sg"]

  tags = {
    Name = "web-server"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "<html>
                    <head>
                      <title>Hello World</title>
                    </head>
                    <body>
                      <h1>Hello World!</h1>
                    </body>
                    </html>" > /var/www/html/index.html
              yum update -y
              yum install httpd -y
              systemctl start httpd
              systemctl enable httpd
              EOF
}

resource "aws_security_group" "web_server_sg" {
  name        = "web-server-sg"
  description = "Security group for web server"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Redirect HTTP to HTTPS
resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = aws_lb_listener.web_server_listener.arn
  priority     = 100

  action {
    type             = "redirect"
    redirect {
      protocol         = "HTTPS"
      port             = "443"
      status_code      = "HTTP_301"
    }
  }

  condition {
    host_header {
      values = ["example.com"]
    }
  }
}

# Automated tests can be implemented using external tools such as Selenium or by invoking HTTP requests to verify the content and behavior of the server.
