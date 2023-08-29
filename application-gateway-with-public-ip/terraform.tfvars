application_gateways = {
 "gateway" = {
    name                               = ""
    location                           = ""
    resource_group_name                = ""
    sku_name                           = ""
    sku_tier                           = ""
    sku_capacity                       = 1
    gateway_ip_configuration_name      = ""
    gateway_ip_subnet_id               = ""
    frontend_public_ip_address_id      = ""
    frontend_subnet_id                 = ""
    frontend_private_ip_address        = ""
    backend_address_pool_name          = ""
    backend_address_pool_ip_addresses  = []
    backend_address_pool_fqdns         = []
    backend_http_settings = {
      "backend_http_settings1" = {
        name                                = ""
        cookie_based_affinity               = ""
        port                                = 443
        protocol                            = "Https"
        request_timeout                     = 60
      }
    }
    http_listeners = {
      "listener1" = {
        name                           = ""
        frontend_ip_configuration_name = ""
        frontend_port_name             = "Http_80"
        protocol                       = "Http"
      }
    }

    url_path_map = {
      "pathmap1" = {
        url_path_map_name                  = ""
        default_backend_address_pool_name  = ""
        default_backend_http_settings_name = ""
        path_rules = [
          {
            name                        = ""
            paths                       = ["/"]
            backend_address_pool_name   = ""
            backend_http_settings_name  = ""
          }
        ]
      }
    }

    request_routing_rules = {
      "rule1" = {
        name                        = ""
        rule_type                   = ""
        http_listener_name          = ""
        backend_address_pool_name   = ""
        backend_http_settings_name  = ""
        url_path_map_name           = ""
        priority                    = 2
      }
    }
}
}
