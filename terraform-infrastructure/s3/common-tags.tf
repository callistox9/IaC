locals {
  common_tags = {
    sdlc             = var.sdlc
    environment_name = var.environment_name
    is_prod          = var.is_prod
  }
}
