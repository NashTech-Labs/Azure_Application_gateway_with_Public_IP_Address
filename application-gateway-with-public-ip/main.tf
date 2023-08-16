terraform {
  required_version = ">= 0.13"
}

provider "azurerm" {
  features {}
}

resource "azurerm_public_ip" "public_ip" {
  for_each = var.application_gateways

  name = "${each.value.name}-public-ip"
  resource_group_name = each.value.resource_group_name
  location = each.value.location
  allocation_method = var.allocation_method
  sku = var.sku-public-ip
}

resource "azurerm_application_gateway" "agw" {
  for_each            = var.application_gateways

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  backend_address_pool {
    name         = each.value.backend_address_pool_name
    ip_addresses = each.value.backend_address_pool_ip_addresses
    fqdns        = each.value.backend_address_pool_fqdns
  }

  dynamic "backend_http_settings" {
    for_each = each.value.backend_http_settings

    content {
      name                                = backend_http_settings.value.name
      cookie_based_affinity               = backend_http_settings.value.cookie_based_affinity
      port                                = backend_http_settings.value.port
      protocol                            = backend_http_settings.value.protocol
      request_timeout                     = backend_http_settings.value.request_timeout
    }
  }

  frontend_ip_configuration {
    name                 = "frontend-public"
    public_ip_address_id = azurerm_public_ip.public_ip[each.key].id
  }

  frontend_ip_configuration {
    name                          = "frontend-private"
    subnet_id                     = each.value.frontend_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = each.value.frontend_private_ip_address
  }

  dynamic "frontend_port" {
    for_each = [80, 443]

    content {
      name = "Http_${frontend_port.value}"
      port = frontend_port.value
    }
  }

  gateway_ip_configuration {
    name      = each.value.gateway_ip_configuration_name
    subnet_id = each.value.gateway_ip_subnet_id
  }

  dynamic "http_listener" {
    for_each = each.value.http_listeners

    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
    }
  }

  dynamic "request_routing_rule" {
    for_each = each.value.request_routing_rules

    content {
      name                        = request_routing_rule.value.name
      rule_type                   = request_routing_rule.value.rule_type
      http_listener_name          = request_routing_rule.value.http_listener_name
      backend_address_pool_name   = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name  = request_routing_rule.value.backend_http_settings_name

      url_path_map_name           = request_routing_rule.value.url_path_map_name
      priority                    = request_routing_rule.value.priority
    }
  }
  
  sku {
    name     = each.value.sku_name
    tier     = each.value.sku_tier
    capacity = each.value.sku_capacity
  }
  dynamic "url_path_map" {
    for_each = each.value.url_path_map

    content {
      name                               = url_path_map.value.url_path_map_name
      default_backend_address_pool_name  = url_path_map.value.default_backend_address_pool_name
      default_backend_http_settings_name = url_path_map.value.default_backend_http_settings_name

      dynamic "path_rule" {
        for_each = url_path_map.value.path_rules

        content {
          name                       = path_rule.value.name
          paths                      = path_rule.value.paths
          backend_address_pool_name  = path_rule.value.backend_address_pool_name
          backend_http_settings_name = path_rule.value.backend_http_settings_name

        }
      }
    }
  } 
}
