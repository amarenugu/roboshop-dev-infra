resource "aws_ssm_parameter" "sg_id" {
    count       = lenth(var.sg_names_)
    name        = "/${var.project}/${var.environment}/mqsql_root_password"
    type        = "SecureString"
    value       = var.mysql_root_password
    overwrite   = true
}