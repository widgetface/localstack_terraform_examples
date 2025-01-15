module "s3_upload" {
  source           = "./modules/s3_private_file_upload"
  fileset_path     = "./data/openapi"
  s3_bucket_prefix = "project-alpha-openapi-"
  s3_object_metadata = {
    "type" : "OpenAPI"
    "author" : "das@mycomp.com"
    "created" : "12/12/2024"
  }
}

module "hello_lambda" {
  source               = "./modules/lambda"
  lambda_function_name = "project_alpha_hello_lambda"
  file_output_path     = "./data/lambda/out/index.zip"
  file_source_path     = "./data/lambda/index.py"
}

module "apig" {
  source              = "./modules/api_gateway_rest"
  apig_name           = "project_alpha_apig_rest"
  apig_description    = "Project alpha API Gateway"
  file_path           = "./data/openapi/test.json"
  stage_name          = "dev"
  lambda_function_arn = module.hello_lambda.lambda_function_arn
  lambda_role_arn     = module.hello_lambda.lambda_function_arn
}

