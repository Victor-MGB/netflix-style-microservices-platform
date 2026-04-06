output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "alb_sg_id" {
  value = module.security_groups.alb_sg_id
}