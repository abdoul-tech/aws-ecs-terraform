terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    # Values will be provided during terraform init
    # bucket = "my-terraform-state-bucket"
    # key = "terraform/app-name/env/terraform.tfstate"
    # region = "us-east-1"
    # encrypt = true
    # dynamodb_table = "terraform_state_lock"
  }
}

provider "aws" {
  region = var.aws_region
}

module "ecs" {
  source = "./modules/ecs"

  aws_region         = var.aws_region
  application_name   = var.application_name
  account_id         = var.account_id
  tg_arn             = module.lb.tg_arn
  cluster_arn        = var.ecs_cluster_arn
  execution_role_arn = var.ecs_execution_role_arn
  sg                 = var.sg_id
  subnet_ecs         = var.subnet_ecs
  default_tags       = var.default_tags
  container_port     = var.ecs_container_port
  host_port          = var.ecs_host_port
  app_image          = var.app_image
  app_count          = var.app_count
  fargate_cpu        = var.fargate_cpu
  fargate_memory     = var.fargate_memory
}

module "lb" {
  source = "./modules/alb"

  application_name  = var.application_name
  vpc_id            = var.vpc_id
  aws_lb_arn        = var.aws_lb_arn
  default_tags      = var.default_tags
  domaines          = var.domaines
  health_check_path = var.health_check_path
}

module "dns" {
  source = "./modules/route53"

  dns_zone_id                 = var.dns_zone_id
  short_name                  = var.short_name
  cloudfront_main_domain_name = module.cloudfront.cloudfront_main_domain_name
  domaines                    = var.domaines
}

module "cloudfront" {
  source = "./modules/cloudfront"

  application_name    = var.application_name
  aliases             = var.domaines
  acm_certificate_arn = var.acm_certificate_arn
  dns_name            = module.lb.dns_name
  default_tags        = var.default_tags
}