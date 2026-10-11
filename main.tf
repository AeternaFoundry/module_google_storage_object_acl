resource "google_storage_object_acl" "storage_object_acls" {
  for_each = var.storage_object_acls

  bucket          = each.value.bucket
  object          = each.value.object
  deletion_policy = each.value.deletion_policy
  predefined_acl  = each.value.predefined_acl
  role_entity     = each.value.role_entity
}

