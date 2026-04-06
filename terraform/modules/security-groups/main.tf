# ALB Security Group - Allows public HTTP/HTTPS
resource "aws_security_group" "alb" {
  name        = var.alb_sg_name
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

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

  tags = { Name = var.alb_sg_name }
}

# EC2 Instances Security Group - Allows traffic only from ALB + SSH from your IP
resource "aws_security_group" "ec2" {
  name        = var.ec2_sg_name
  description = "Security group for EC2 instances (API, Worker, etc.)"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]   # Only from ALB
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["105.117.25.215/32"]   # ← Change to your public IP (check whatismyip.com)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = var.ec2_sg_name }
}

# Monitoring SG (Prometheus + Grafana)
resource "aws_security_group" "monitoring" {
  name        = var.monitoring_sg_name
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 9090   # Prometheus
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]   # Internal only
  }

  ingress {
    from_port   = 3000   # Grafana
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["105.117.25.215/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = var.monitoring_sg_name }
}

output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2.id
}

output "monitoring_sg_id" {
  value = aws_security_group.monitoring.id
}