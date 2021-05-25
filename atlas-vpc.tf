resource "mongodbatlas_database_user" "db_user" {
  username           = var.altas_username
  password           = var.atlas_password
  project_id         = "PROJECT 0"
  auth_database_name = "admin"
  
  #readWriteAnyDatabase@admin
  roles {
    role_name     = "readAnyDatabase"
    database_name = "admin"
  }
}

resource "mongodbatlas_network_peering" "atlas_peering" {
  
}