module "vpc" {
    source = "git::https://github.com/amarenugu/terraform-aws-vpc.git?ref=main"
    project = var.project
    environment = var.environment
    is_peering_required = false
}