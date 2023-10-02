module "vpc" {
  source = "./modules/vpc"
}

module "alb" {
  source          = "./modules/alb"
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.subnet_ids
  security_group  = module.vpc.ecs_tasks_sg_id
}

module "ecs" {
  source            = "./modules/ecs"
  subnets           = module.vpc.subnet_ids
  security_group    = module.vpc.ecs_tasks_sg_id
  target_group_arn  = module.alb.target_group_arn
}

provider "aws" {
  region = "us-west-2"
}
