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

resource "aws_quicksight_data_set" "customers" {
  aws_account_id = data.aws_caller_identity.current.account_id

  data_set_id = "dev-customers-dataset"
  name        = "dev-customers-dataset"

  import_mode = "DIRECT_QUERY"
  permissions {
    principal = "arn:aws:quicksight:us-east-1:801333664304:user/default/jasvik"

    actions = [
      "quicksight:DescribeDataSet",
      "quicksight:DescribeDataSetPermissions",
      "quicksight:PassDataSet",
      "quicksight:DescribeIngestion",
      "quicksight:ListIngestions"
    ]
  }
  physical_table_map {
    physical_table_map_id = "customers"

    relational_table {
      data_source_arn = aws_quicksight_data_source.redshift.arn

      catalog = "dev"
      schema  = "public"
      name    = "customers"

      input_columns {
        name = "name"
        type = "STRING"
      }

      input_columns {
        name = "age"
        type = "INTEGER"
      }

      input_columns {
        name = "sex"
        type = "STRING"
      }

      input_columns {
        name = "address"
        type = "STRING"
      }

      input_columns {
        name = "mobile_number"
        type = "STRING"
      }

      input_columns {
        name = "has_netflix_subscription"
        type = "BOOLEAN"
      }

      input_columns {
        name = "netflix_plan"
        type = "STRING"
      }

      input_columns {
        name = "subscription_start_date"
        type = "DATETIME"
      }

      input_columns {
        name = "subscription_end_date"
        type = "DATETIME"
      }
    }
  }
}

resource "aws_quicksight_template" "customers" {
  aws_account_id = data.aws_caller_identity.current.account_id

  template_id         = "dev-customers-template"
  name                = "dev-customers-template"
  version_description = "Initial version"

  source_entity {
    source_analysis {
      arn = data.aws_quicksight_analysis.customers.arn

      data_set_references {
        data_set_arn        = aws_quicksight_data_set.customers.arn
        data_set_placeholder = "dev-customers-dataset"
      }
    }
  }

  permissions {
    principal = "arn:aws:quicksight:us-east-1:801333664304:user/default/jasvik"

    actions = [
      "quicksight:DescribeTemplate",
      "quicksight:DescribeTemplatePermissions",
      "quicksight:UpdateTemplate",
      "quicksight:DeleteTemplate",
      "quicksight:ListTemplateVersions"
    ]
  }
}

resource "aws_quicksight_dashboard" "customers" {
  aws_account_id = data.aws_caller_identity.current.account_id

  dashboard_id        = "dev-customers-dashboard"
  name                = "dev-customers-dashboard"
  version_description = "Initial DEV dashboard"

  source_entity {
    source_template {
      arn = aws_quicksight_template.customers.arn

      data_set_references {
        data_set_arn         = aws_quicksight_data_set.customers.arn
        data_set_placeholder = "dev-customers-dataset"
      }
    }
  }

  permissions {
    principal = "arn:aws:quicksight:us-east-1:801333664304:user/default/jasvik"

    actions = [
      "quicksight:DescribeDashboard",
      "quicksight:ListDashboardVersions",
      "quicksight:UpdateDashboard",
      "quicksight:QueryDashboard",
      "quicksight:DescribeDashboardPermissions",
      "quicksight:UpdateDashboardPermissions"
    ]
  }
}