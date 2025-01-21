

locals {
  name = "${var.region_short}-${var.sdlc}-${var.environment_name}"

  s3_additional_tags = {
    
    customer_critical = "true"
  }
 
}
# Doc -- https://github.com/terraform-aws-modules/terraform-aws-s3-bucket
module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  for_each = var.s3_configs

  bucket = try("${var.region_short}-${var.environment_name}-${each.value.s3_name_suffix}", null)

  block_public_acls       = try(each.value.s3_block_public_acls, true)
  ignore_public_acls      = try(each.value.s3_ignore_public_acls, true)
  block_public_policy     = try(each.value.s3_block_public_policy, true)
  restrict_public_buckets = try(each.value.s3_restrict_public_buckets, true)

  cors_rule = try(each.value.cors_rule, [])

  server_side_encryption_configuration = try(each.value.s3_server_side_encryption_configuration, {})

  lifecycle_rule = try(each.value.lifecycle_rules, [])


  website = {
    index_document = try(each.value.s3_index_document, "index.html")
    error_document = try(each.value.s3_error_document, "error.html")
  }
  


  object_ownership = try(each.value.object_ownership, "BucketOwnerEnforced")

  versioning = {
    enabled = try(each.value.s3_versioning, null)
  }

  force_destroy = try(each.value.s3_force_destroy, null)

  tags = merge(
    local.common_tags,
    local.s3_additional_tags
  )
}
resource "aws_s3_bucket_policy" "bucket_policy" {
  for_each = var.s3_configs

  bucket = module.s3-bucket[each.key].s3_bucket_id

  policy = jsonencode(
    {
      Version = lookup(each.value.bucket_policy, "Version", "2012-10-17")
      Statement = [
        for statement in lookup(each.value.bucket_policy, "Statement", []) : {
          Sid       = lookup(statement, "Sid", "")
          Effect    = statement.Effect
          Principal = statement.Principal
          Action    = statement.Action
          Resource  = replace(statement.Resource, "BUCKET_ARN_PLACEHOLDER", module.s3-bucket[each.key].s3_bucket_arn)
        }
      ]
    }
  )
}

