variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default   = "us-west-1"
  sensitive = true
}
variable "MONGODB_ATLAS_PUBLIC_KEY" {}
variable "MONGODB_ATLAS_PRIVATE_KEY" {}

variable "x" {
  type =string
}