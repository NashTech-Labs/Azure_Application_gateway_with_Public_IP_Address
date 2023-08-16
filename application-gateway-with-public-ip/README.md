# application-gateway

This Terraform Git repo contains a code that create application gateway with public ip address in Azure.

## Prerequisites

Before you can use this Terraform code, you will need to have the following installed:

- [Terraform]
- [Azure CLI]
- Azure account with Owner permission.
- Resource group
- Virtual Network with Subnets

## Usage

To use this Terraform code

Clone this Git repo to your local machine.

Change into the directory containing the code.

```bash
cd application-gateway
cd code

```

Create a new file named `terraform.tfvars` in the same directory as your `.tf` files.

```bash
touch terraform.tfvars
```

Open the file in your preferred text editor.

```bash

nano terraform.tfvars
```

Add your desired inputs to the file in the following format:

```ruby
application_gateways = {
 "gateway" = {
    name                               = "application_gateway"
    location                           = "eastus"
    resource_group_name                = "app-gateway"
    sku_name                           = "Standard_v2"
    sku_tier                           = "Standard_v2"
    sku_capacity                       = 1
    gateway_ip_configuration_name      = ""
    gateway_ip_subnet_id               = "existing subnet resource-ID" # you can provide the resource id ex- /subscriptions/{subscription-id}/resourceGroups/{resource-group-name}/providers/Microsoft.Network/virtualNetworks/{vnet-name}/subnets/{subnet-name}
    frontend_public_ip_address_id      = "provide your public ip address name"
    frontend_subnet_id                 = "existing subnet resource-ID" # you can provide the resource id ex- /subscriptions/{subscription-id}/resourceGroups/{resource-group-name}/providers/Microsoft.Network/virtualNetworks/{vnet-name}/subnets/{subnet-name}
    frontend_private_ip_address        = "front end private IP"
    backend_address_pool_name          = "backend pool name"
    backend_address_pool_ip_addresses  = []
    backend_address_pool_fqdns         = []
    backend_http_settings = {
      "backend_http_settings1" = {
        name                                = ""
        cookie_based_affinity               = "Disabled"
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
            paths                       = [""]
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
```
Review the changes that Terraform will make to your Azure resources.


Initialize Terraform in the directory.

```bash
terraform init
```
```bash
terraform plan 
```
```bash
terraform apply 

```
