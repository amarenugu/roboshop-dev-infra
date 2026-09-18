locals {
    backend_alb_sg_id   = data.aws_ssm_parameter.backend_alb_sg_id.value
    common_name         = "${var.project}-${var.environment}"
    private_subnet_id   = split(",", data.aws_ssm_parameter.private_subnet_id.value)[0] # roboshop-dev-private_subnet_id-1a
    common_tags = {
        Project         = "${var.project}"
        Environment     = "${var.environment}"
        Terraform       = "true"
    }
}