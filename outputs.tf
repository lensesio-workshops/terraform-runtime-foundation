output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "EKS cluster CA data"
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

output "configure_kubectl" {
  description = "Command to configure kubectl"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnets
}

output "acm_certificate_arn" {
  description = "ACM wildcard certificate ARN"
  value       = aws_acm_certificate.wildcard.arn
}

output "route53_zone_id" {
  description = "Route53 hosted zone ID"
  value       = local.zone_id
}

output "route53_nameservers" {
  description = "Route53 nameservers (update your domain registrar)"
  value       = var.route53_zone_id != "" ? data.aws_route53_zone.existing[0].name_servers : aws_route53_zone.main[0].name_servers
}
