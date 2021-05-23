provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  #profile    = "default"
  region     = var.AWS_REGION
}
