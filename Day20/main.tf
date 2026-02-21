module "s3" {
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
  tags        = var.tags
}


module "vpc" {
  source     = "./modules/vpc"
  new_bucket = module.s3.s3_url
}
