data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_redshiftserverless_workgroup" "dev" {
  workgroup_name = "dev-workgroup"
}

data "aws_redshiftserverless_namespace" "dev" {
  namespace_name = "dev-namespace"
}

