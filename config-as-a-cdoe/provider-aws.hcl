locals {
  # Automatically load account-level variables
  root_deployments_dir       = get_parent_terragrunt_dir()
  relative_deployment_path   = path_relative_to_include()
  deployment_path_components = compact(split("/", local.relative_deployment_path))
  state_path                 = join("/", slice(local.deployment_path_components, 2, length(local.deployment_path_components)))
  env                        = local.deployment_path_components[2]
  # account_handle             = local.deployment_path_components[3]
  aws_region                 = local.deployment_path_components[3]

  # Get a list of every path between root_deployments_directory and the path of
  # the deployment
  possible_config_dirs = [
    for i in range(0, length(local.deployment_path_components) + 1) :
    join("/", concat(
      ["${local.root_deployments_dir}"],
      slice(local.deployment_path_components, 0, i)
    ))
  ]

  # Generate a list of possible config files at every possible_config_dir
  # (support both .yml and .yaml)
  possible_config_paths = flatten([
    for dir in local.possible_config_dirs : [
      "${dir}/config.yml",
      "${dir}/config.yaml",
    ]
  ])

  # Load every YAML config file that exists into an HCL map
  file_configs = [
    for path in local.possible_config_paths :
    yamldecode(file(path)) if fileexists(path)
  ]

  # Merge the maps together, with deeper configs overriding higher configs
  merged_config = merge(local.file_configs...)

  tfstate_account = "891376921657"
  tfstate_account_role_name = "github_oidc_iam_role_for_terragrunt"
  role_name = "terraform-automation"




  account_name = "aws-effibuild-${local.merged_config.account_id}-${local.env}"
}


remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "eb-aws-tfstate"
    region         = "us-east-1"
    encrypt        = true
    key            = "${local.merged_config.account_id}/${local.deployment_path_components[0]}/${local.state_path}/terraform.tfstate"
    role_arn = "arn:aws:iam::${local.tfstate_account}:role/${local.tfstate_account_role_name}"
    dynamodb_table = "eb-tf-lock"
  }
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
  default_tags {
    tags = {
      automation           = "true"
      automation_via       = "terragrunt"
      owner                = "cloudops"
    }
  }
  allowed_account_ids = ["${local.merged_config.account_id}"]
  assume_role {
    role_arn= "arn:aws:iam::${local.merged_config.account_id}:role/${local.role_name}"
  }    
}
EOF
}

terraform {
# TODO for later​
# ​use this strategy to avoid web hooks​
# ​https://chatgpt.com/share/c1d05d64-8883-4f85-90c9-5bcde3d951a0

  # Copy shared modules
  // before_hook "before" {
  //   commands     = ["init", "apply", "destroy", "plan"]
  //   execute      = ["cp", "-rf", "${get_repo_root()}/common-modules", "."]
  // }

  // after_hook "clean" {
  //   commands     = ["init", "apply", "destroy", "plan"]
  //   execute      = ["rm", "-rf", "common-modules"]
  //   run_on_error = true
  // }

  // before_hook "lambdas" {
  //   commands     = ["init", "apply", "destroy", "plan"]
  //   execute      = ["cp", "-rf", "${get_repo_root()}/stateful", "."]
  // }
  //   after_hook "clean_lambdas" {
  //   commands     = ["init", "apply", "destroy", "plan"]
  //   execute      = ["rm", "-rf", "lambdas"]
  //   run_on_error = true
  // }

  before_hook "api_spec" {
    commands     = ["init", "apply", "destroy", "plan"]
    execute      = ["cp", "-rf", "${get_repo_root()}/api_spec", "."]
  }

  # after_hook "clean_api_spec" {
  #   commands     = ["init", "apply", "destroy", "plan"]
  #   execute      = ["rm", "-rf", "api_spec"]
  #   run_on_error = true
  # }
   before_hook "lambdas" {
     commands     = ["init", "apply", "destroy", "plan"]
     execute      = ["cp", "-rf", "${get_repo_root()}/lambdas", "."]
   }

  // after_hook "clean_lambdas" {
  //   commands     = ["init", "apply", "destroy", "plan"]
  //   execute      = ["rm", "-rf", "${get_repo_root()}/lambdas", "."]
  //   run_on_error = true
  // }


  # before_hook "authorizer" {
  #   commands     = ["init", "apply", "destroy", "plan"]
  #   execute      = ["cp", "-rf", "${get_repo_root()}/authorizer", "."]
  # }

  # before_hook "api_spec" {
  #   commands     = ["init", "apply", "destroy", "plan"]
  #   execute      = ["cp", "-rf", "${get_repo_root()}/api_spec", "."]
  # }
}
