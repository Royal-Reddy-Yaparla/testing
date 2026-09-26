# variable "aws_account_id" {
#   description = "AWS account ID used by the QuickSight data source."
#   type        = string
# }

# variable "redshift_host" {
#   description = "Hostname of the Redshift cluster."
#   type        = string
# }

# variable "redshift_database" {
#   description = "Name of the Redshift database."
#   type        = string
# }

variable "quicksight_vpc_connection_arn" {
  description = "ARN of the QuickSight VPC connection."
  type        = string
  default     = "arn:aws:quicksight:us-east-1:801333664304:vpcConnection/90918b5d-1114-429f-a9d8-32477b584582"
}

variable "redshift_username" {
  description = "Username for the Redshift database."
  type        = string
}


variable "redshift_password" {
  description = "Password for the Redshift database."
  type        = string
  sensitive   = true
}