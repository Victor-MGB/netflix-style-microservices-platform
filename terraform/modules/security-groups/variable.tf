variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "alb_sg_name" {
  default = "alb-security-group"
}

variable "ec2_sg_name" {
  default = "ec2-instances-sg"
}

variable "monitoring_sg_name" {
  default = "monitoring-sg"
}