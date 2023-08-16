output "application-gateway" {
    description = "application-gateway details"
    value = azurerm_application_gateway.agw["gateway"].id
}
