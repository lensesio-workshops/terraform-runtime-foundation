# Lenses Training Infrastructure - Foundation

EKS cluster foundation for Lenses training environments.

## What This Creates

- VPC with public/private subnets across 3 AZs
- EKS 1.33 cluster with AL2023 nodes
- AWS Load Balancer Controller (for ALB ingress)
- EBS CSI Driver (for persistent volumes)
- Strimzi Kafka Operator (watches all namespaces)
- Route53 hosted zone for `lenses.training`
- Wildcard ACM certificate (`*.lenses.training`)

## Node Configuration

| Setting | Default |
|---------|---------|
| Instance Type | m6i.4xlarge (16 vCPU / 64GB) |
| Min Nodes | 6 |
| Max Nodes | 12 |
| Desired Nodes | 8 |
| AMI | Amazon Linux 2023 |

## Prerequisites

- Terraform >= 1.5
- AWS CLI configured with appropriate permissions
- Domain `lenses.training` (or update `domain_name` variable)

## Deploy

```bash
# Configure
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars if needed

# Initialize
terraform init

# Plan
terraform plan

# Apply
terraform apply
```

## Post-Deploy

```bash
# Configure kubectl
aws eks update-kubeconfig --region us-east-2 --name lenses-training

# Verify cluster
kubectl get nodes

# Verify Strimzi operator
kubectl get pods -n strimzi-system

# Verify Load Balancer Controller
kubectl get pods -n kube-system | grep aws-load-balancer
```

## Outputs

After apply, you'll see:
- `configure_kubectl` - Command to configure kubectl
- `acm_certificate_arn` - Use this in student ingress annotations
- `route53_zone_id` - For creating DNS records
- `route53_nameservers` - Update your domain registrar if needed

## Cost Estimate

~$1,500-2,000/day when running 8x m6i.4xlarge nodes.

To scale down when not in use:

```bash
aws eks update-nodegroup-config \
  --cluster-name lenses-training \
  --nodegroup-name primary \
  --scaling-config minSize=0,maxSize=12,desiredSize=0 \
  --region us-east-2
```

## Destroy

```bash
terraform destroy
```
