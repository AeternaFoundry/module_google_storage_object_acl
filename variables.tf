variable "storage_object_acls" {
  description = <<EOT
Map of storage_object_acls, attributes below
Required:
    - bucket
    - object
Optional:
    - deletion_policy
    - predefined_acl
    - role_entity
EOT

  type = map(object({
    bucket          = string
    object          = string
    deletion_policy = optional(string)
    predefined_acl  = optional(string)
    role_entity     = optional(set(string))
  }))
  validation {
    condition = alltrue([
      for k, v in var.storage_object_acls : (
        v.predefined_acl == null || (contains(["private", "bucketOwnerRead", "bucketOwnerFullControl", "projectPrivate", "authenticatedRead", "publicRead", ""], v.predefined_acl))
      )
    ])
    error_message = "must be one of: \"private\", \"bucketOwnerRead\", \"bucketOwnerFullControl\", \"projectPrivate\", \"authenticatedRead\", \"publicRead\", \"\""
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

