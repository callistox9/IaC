
variable "s3_configs" {
  description = "s3_configs"
  type        = any
  default     = {}
}

# variable "s3_name_suffix" {
#   description = "Name for the S3 bucket"
#   type        = string
# }



# variable "s3_acl" {
#   description = "The canned ACL to apply"
#   type        = string
#   default     = "private"
# }

# variable "s3_versioning" {
#   description = "Enable versioning. Once you version-enable a bucket, it can never return to an unversioned state"
#   type        = bool
#   default     = false
# }

# variable "s3_force_destroy" {
#   description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
#   type        = bool
#   default     = false
# }

# variable "s3_tags" {
#   description = "A mapping of tags to assign to the bucket"
#   type        = map(string)
#   default     = {}
# }

