locals {
  environment_map = {
    dev     = "d"
    uat     = "u"
    prod    = "p"
    pground = "c"
  }

  environment_single_char = local.environment_map[var.environment]

  appgw_environment_map = {
    dev     = "d"
    uat     = "d"
    prod    = "p"
  }

  appgw_environment_single_char = local.appgw_environment_map[var.environment]

  tags = merge(
    var.tags,
    {

  })

}
