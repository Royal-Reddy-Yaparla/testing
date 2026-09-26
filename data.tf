data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_redshiftserverless_workgroup" "dev" {
  workgroup_name = "dev-workgroup"
}

data "aws_redshiftserverless_namespace" "dev" {
  namespace_name = "dev-namespace"
}

data "aws_quicksight_analysis" "customers" {
  aws_account_id = data.aws_caller_identity.current.account_id
  analysis_id    = "f6f20734-b942-49bd-a24c-a96492118c25"
  region         = "us-east-1"
}