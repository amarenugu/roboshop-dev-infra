module "components" {
    for_each    = var.components
    source ="../../terraform-roboshop-component"
    environment = var.environment
    component   = each.key
    app_version = each.value.app_version

}