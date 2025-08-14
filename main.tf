data "aws_ecr_repository" "counter-service-repo" {
  name = "counter-service-repo-new"
}

module "vpc" {
  source = "./modules/vpc"
}

module "ecs" {
  source = "./modules/ecs"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnets_ids = module.vpc.private_subnet_ids
  ecr_repo_url = data.aws_ecr_repository.counter-service-repo.repository_url
}

module "cloudfront" {
  source = "./modules/cloudfront"
  alb_dns_name = module.ecs.alb_dns_name
}