variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default   = "us-west-1"
  sensitive = true
}
variable "MONGODB_ATLAS_PUBLIC_KEY" {}
variable "MONGODB_ATLAS_PRIVATE_KEY" {}
variable "MONGODB_ATLAS" {
  default   = "US-WEST-1"
}

variable "atlas_cidr" {
  description = "Atlas VPC CIDR"
}
variable "atlas_org_id" {
  description = "Atlas Orgainzation ID"
}

variable "altas_username" {
  description = "Atlas User Name"
}

variable "atlas_password" {
  description = "Atlas Password"
}

variable "x" {
  type =string
}