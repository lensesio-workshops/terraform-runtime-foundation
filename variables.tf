variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "lenses-training"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.33"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "m6i.4xlarge"
}

variable "node_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 6
}

variable "node_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 12
}

variable "node_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 8
}

variable "domain_name" {
  description = "Domain name for ingress"
  type        = string
  default     = "lenses.training"
}

variable "route53_zone_id" {
  description = "Existing Route53 zone ID. If provided, uses existing zone instead of creating new one."
  type        = string
  default     = ""
}
