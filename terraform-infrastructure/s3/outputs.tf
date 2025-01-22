output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value = {
    for k, v in module.s3-bucket : k => v.s3_bucket_arn
  }
}

output "s3_bucket_bucket_domain_name" {
  description = "The bucket domain name"
  value = {
    for k, v in module.s3-bucket : k => v.s3_bucket_bucket_domain_name
  }
}

output "s3_bucket_bucket_regional_domain_name" {
  description = "The bucket regional domain name"
  value = {
    for k, v in module.s3-bucket : k => v.s3_bucket_bucket_regional_domain_name
  }
}

output "s3_bucket_hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID for this bucket's region"
  value = {
    for k, v in module.s3-bucket : k => v.s3_bucket_hosted_zone_id
  }
}

output "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value = {
    for k, v in module.s3-bucket : k => v.s3_bucket_id
  }
}
output "s3_bucket_region" {
  description = "The AWS region where the S3 bucket resides"
  value = {
    for k, v in module.s3-bucket : k => v.s3_bucket_region
  }
}

output "s3_bucket_website_domain" {
  description = "The website domain of the S3 bucket (if configured)"
  value = {
    for k, v in module.s3-bucket : k => v.s3_bucket_website_domain
  }
}

output "s3_bucket_website_endpoint" {
  description = "The website endpoint of the S3 bucket (if configured)"
  value = {
    for k, v in module.s3-bucket : k => v.s3_bucket_website_endpoint
  }
}









# output "s3_bucket_arn" {
#   description = "The ARN of the S3 bucket"
#   value       = module.s3-bucket.s3_bucket_arn
# }

# output "s3_bucket_id" {
#   description = "The name of the S3 bucket"
#   value       = module.s3-bucket.s3_bucket_id
# }

# output "s3_bucket_domain_name" {
#   description = "The domain name of the S3 bucket"
#   value       = module.s3-bucket.s3_bucket_domain_name
# }

# output "s3_bucket_acl" {
#   description = "The canned ACL to apply"
#   value       = module.s3-bucket.s3_bucket_acl
# }

# output "s3_bucket_versioning_enabled" {
#   description = "A state of versioning (documented below)"
#   value       = module.s3-bucket.s3_bucket_versioning_enabled
# }

# output "s3_bucket_region" {
#   description = "The AWS region this S3 bucket resides in"
#   value       = module.s3-bucket.s3_bucket_region
# }

# output "s3_bucket_hosted_zone_id" {
#   description = "The Route 53 Hosted Zone ID for this bucket's region"
#   value       = module.s3-bucket.s3_bucket_hosted_zone_id
# }

# output "s3_bucket_website_endpoint" {
#   description = "The website endpoint, if the bucket is configured with a website. If not, this will be an empty string"
#   value       = module.s3-bucket.s3_bucket_website_endpoint
# }

# output "s3_bucket_website_domain" {
#   description = "The domain of the website endpoint"
#   value       = module.s3-bucket.s3_bucket_website_domain
# }

# output "s3_bucket_server_side_encryption_configuration" {
#   description = "A configuration of server-side encryption (documented below)"
#   value       = module.s3-bucket.s3_bucket_server_side_encryption_configuration
# }

# output "s3_bucket_force_destroy" {
#   description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error"
#   value       = module.s3-bucket.s3_bucket_force_destroy
# }

# output "s3_bucket_policy" {
#   description = "The bucket policy JSON"
#   value       = module.s3-bucket.s3_bucket_policy
# }

# output "s3_bucket_tags" {
#   description = "A mapping of tags to assign to the bucket"
#   value       = module.s3-bucket.s3_bucket_tags
# }


# output "s3_bucket_hosted_zone_id" {
#   description = "The Route 53 Hosted Zone ID for this bucket's region"
#   value       = module.s3-bucket.s3_bucket_hosted_zone_id
# }
