variable "allocation_method" {
  default = "Static"

}

variable "sku-public-ip" {
  default = "Standard"
}

variable "application_gateways" {
  description = "Application Gateway configurations"
  type = map(object({
    name                                = string
    resource_group_name                 = string
    location                            = string
    backend_address_pool_name           = string
    backend_address_pool_ip_addresses   = list(string)
    backend_address_pool_fqdns          = list(string)

    backend_http_settings = map(object({
      name                                = string
      cookie_based_affinity               = string
      port                                = number
      protocol                            = string
      request_timeout                     = number
    }))

    frontend_public_ip_address_id   = string
    frontend_subnet_id              = string
    frontend_private_ip_address     = string
    gateway_ip_configuration_name   = string
    gateway_ip_subnet_id            = string

    http_listeners = map(object({
      name                           = string
      frontend_ip_configuration_name = string
      frontend_port_name             = string
      protocol                       = string
    }))

    request_routing_rules = map(object({
      name                        = string
      rule_type                   = string
      http_listener_name          = string
      backend_address_pool_name   = string
      backend_http_settings_name  = string
      url_path_map_name           = string
      priority                    = number
    }))

    sku_name        = string
    sku_tier        = string
    sku_capacity    = number

    url_path_map = map(object({
      url_path_map_name                  = string
      default_backend_address_pool_name  = string
      default_backend_http_settings_name = string
      path_rules = list(object({
        name                        = string
        paths                       = list(string)
        backend_address_pool_name   = string
        backend_http_settings_name  = string
      }))
    }))

  }))
}
