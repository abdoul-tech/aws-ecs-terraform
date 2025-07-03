# AWS ECS Terraform Configuration

This Terraform configuration creates a complete AWS ECS environment with the following components:

- **ECS Fargate Service** - Containerized application deployment
- **Application Load Balancer** - Load balancing and SSL termination
- **CloudFront Distribution** - Content delivery network
- **Route53 DNS Records** - Domain name management
- **CloudWatch Logs** - Application logging

## Prerequisites

Before using this configuration, ensure you have:

1. **AWS CLI** configured with appropriate credentials
2. **Terraform** installed (version 1.0+)
3. **Existing AWS Resources**:
   - VPC with public and private subnets
   - Application Load Balancer
   - ECS Cluster
   - ECS Task Execution Role
   - Security Groups
   - ACM Certificate
   - Route53 Hosted Zone

## Quick Start

1. **Clone and Configure**:
   ```bash
   git clone https://github.com/abdoul-tech/aws-ecs-terraform.git
   cd aws-ecs-terraform
   cp terraform.tfvars.dist terraform.tfvars
   ```

2. **Edit Configuration**:
   Update `terraform.tfvars` with your specific values:
   ```hcl
   # Basic Configuration
   aws_region       = "us-east-1"
   application_name = "my-app"
   short_name       = "myapp"
   account_id       = "123456789012"
   
   # Domain and SSL Configuration
   dns_zone_id         = "Z1234567890ABC"
   acm_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/..."
   domaines            = ["app.example.com"]
   
   # ECS Configuration
   ecs_execution_role_arn = "arn:aws:iam::123456789012:role/ecsTaskExecutionRole"
   ecs_cluster_arn        = "arn:aws:ecs:us-east-1:123456789012:cluster/my-cluster"
   
   # Application Configuration
   app_image         = "nginx:latest"
   app_count         = 2
   fargate_cpu       = 1024
   fargate_memory    = 2048
   
   # Network Configuration
   vpc_id     = "vpc-12345678"
   sg_id      = "sg-12345678"
   aws_lb_arn = "arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/my-alb/..."
   
   subnet_ecs = [
     "subnet-12345678",
     "subnet-87654321",
   ]
   ```

3. **Initialize and Deploy**:
   ```bash
   # Initialize Terraform
   terraform init
   
   # Plan the deployment
   terraform plan
   
   # Apply the configuration
   terraform apply
   ```

## Configuration Variables

### Required Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `aws_region` | AWS region | `us-east-1` |
| `application_name` | Application name | `my-app` |
| `account_id` | AWS account ID | `123456789012` |
| `dns_zone_id` | Route53 hosted zone ID | `Z1234567890ABC` |
| `acm_certificate_arn` | ACM certificate ARN | `arn:aws:acm:...` |
| `ecs_execution_role_arn` | ECS execution role ARN | `arn:aws:iam::...` |
| `ecs_cluster_arn` | ECS cluster ARN | `arn:aws:ecs:...` |
| `aws_lb_arn` | Application Load Balancer ARN | `arn:aws:elasticloadbalancing:...` |
| `vpc_id` | VPC ID | `vpc-12345678` |
| `sg_id` | Security group ID | `sg-12345678` |
| `subnet_ecs` | ECS subnet IDs | `["subnet-1", "subnet-2"]` |
| `domaines` | Domain names | `["app.example.com"]` |

### Optional Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `app_image` | Docker image | `strm/helloworld-http` |
| `app_count` | Number of tasks | `1` |
| `fargate_cpu` | CPU units | `1024` |
| `fargate_memory` | Memory in MB | `2048` |
| `health_check_path` | Health check path | `/` |
| `ecs_container_port` | Container port | `80` |
| `ecs_host_port` | Host port | `80` |

## Outputs

After deployment, you'll see the following outputs:

- `cloudfront_domain_name` - CloudFront distribution domain
- `alb_dns_name` - Load balancer DNS name
- `target_group_arn` - Target group ARN
- `ecs_service_name` - ECS service name
- `log_group_name` - CloudWatch log group name

## Architecture

```
Internet → CloudFront → ALB → ECS Fargate Tasks
                        ↓
                   Route53 DNS
```

## Backend Configuration

For production use, configure the S3 backend:

```bash
terraform init \
  -backend-config="bucket=my-terraform-state-bucket" \
  -backend-config="key=terraform/my-app/prod/terraform.tfstate" \
  -backend-config="region=us-east-1" \
  -backend-config="encrypt=true" \
  -backend-config="dynamodb_table=terraform_state_lock"
```

## Troubleshooting

### Common Issues

1. **Service fails to start**: Check security group rules and subnet configuration
2. **Health checks failing**: Verify the `health_check_path` and application response
3. **DNS not resolving**: Ensure the Route53 hosted zone is properly configured
4. **SSL/TLS issues**: Verify the ACM certificate covers all specified domains

### Monitoring

- **ECS Service**: Check the ECS console for task status
- **Logs**: View CloudWatch logs at `/ecs/{application_name}-{workspace}/app`
- **Load Balancer**: Monitor target group health in the EC2 console

## Clean Up

To destroy the infrastructure:

```bash
terraform destroy
```

## Security Considerations

- Use least privilege IAM roles
- Enable VPC Flow Logs
- Configure WAF rules for CloudFront
- Use secrets manager for sensitive data
- Enable CloudTrail for audit logging

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License.
