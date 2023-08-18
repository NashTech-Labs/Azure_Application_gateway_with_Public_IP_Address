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
    frontend_public_ip_address_id      = "application-gateway-public-ip"
    frontend_subnet_id                 = ""
    frontend_private_ip_address        = ""
    backend_address_pool_name          = ""
    backend_address_pool_ip_addresses  = []
    backend_address_pool_fqdns         = []
    backend_http_settings = {
      "backend_http_settings1" = {
        name                                = "my-http-settings"
        cookie_based_affinity               = "Disabled"
        port                                = 443
        protocol                            = "Https"
        request_timeout                     = 60
      }
    }
    http_listeners = {
      "listener1" = {
        name                           = "my-listeners"
        frontend_ip_configuration_name = "frontend-private"
        frontend_port_name             = "Http_80"
        protocol                       = "Http"
      }
    }

    url_path_map = {
      "pathmap1" = {
        url_path_map_name                  = "my-url-path-map121"
        default_backend_address_pool_name  = "backend-pool"
        default_backend_http_settings_name = "my-http-settings"
        path_rules = [
          {
            name                        = "my-path-rule"
            paths                       = ["/apps/*"]
            backend_address_pool_name   = "backend-pool"
            backend_http_settings_name  = "my-http-settings"
          }
        ]
      }
    }

    request_routing_rules = {
      "rule1" = {
        name                        = "my-routing-rule"
        rule_type                   = "PathBasedRouting"
        http_listener_name          = "my-listeners"
        backend_address_pool_name   = "backend-pool"
        backend_http_settings_name  = "my-http-settings"
        url_path_map_name           = "my-url-path-map121"
        priority                    = 2
      }
    }
}
}
