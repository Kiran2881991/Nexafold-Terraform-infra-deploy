locals {
  environment_map = {
    dev     = "d"
    uat     = "u"
    prod    = "p"
  }

  # EscapeV2      006525
 
  environment_single_char = local.environment_map[var.environment]

  #location_code = {
  #  francecentral = "em28"
  # }

  tags = merge(
    var.tags,
    {

  })

}
