resource "aws_quicksight_data_source" "redshift" {
  data_source_id = "dev-redshift-datasource"
  name           = "dev-redshift-datasource"
  type           = "REDSHIFT"

  aws_account_id = data.aws_caller_identity.current.account_id

  parameters {
    redshift {
      host     = data.aws_redshiftserverless_workgroup.dev.endpoint[0].address
      port     = data.aws_redshiftserverless_workgroup.dev.endpoint[0].port
      database = data.aws_redshiftserverless_namespace.dev.db_name
    }
  }
  
  credentials {
  credential_pair {
    username = var.redshift_username
    password = var.redshift_password
  }
}

  vpc_connection_properties {
    vpc_connection_arn = var.quicksight_vpc_connection_arn
  }

  permission {
    principal = "arn:aws:quicksight:us-east-1:801333664304:user/default/jasvik"

    actions = [
      "quicksight:DescribeDataSource",
      "quicksight:DescribeDataSourcePermissions",
      "quicksight:PassDataSource"
    ]
  }
}