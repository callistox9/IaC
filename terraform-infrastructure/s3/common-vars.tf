variable "region" {
  type        = string
  description = "region to deploy to"
}

variable "account_id" {
  type        = string
  description = "account id"
}

# variable "env" {
#   type        = string
#   description = "env to deploy to"
# }

variable "environment_name" {
  type        = string
  description = "env to deploy to"
}

variable "common_config" {
  description = "common config"
  type        = any
  default     = {}
}

variable "global" {
  description = "global config"
  type        = any
  default     = {}
}

variable "region_short" {
  description = "Region Short Name"
  type        = string

}
variable "sdlc" {
  description = "Software Development Life Cycle"
  type        = string
}
variable "is_prod" {
  description = "Is this a production environment"
  type        = bool
}
