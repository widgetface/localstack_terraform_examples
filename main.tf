module "s3_upload" {
  source           = "./modules/s3_private_file_upload"
  fileset_path     = "./data"
  s3_bucket_prefix = "project-alpha-openapi-"
  s3_object_metadata = {
    "type" : "OpenAPI"
    "author" : "das@mycomp.com"
    "created" : "12/12/2024"
  }
}