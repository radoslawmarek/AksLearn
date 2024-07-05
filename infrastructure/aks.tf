locals {
  aks_cluster_name       = "aks-${var.app_name}-${var.app_version}"
  default_node_pool_name = "npdefault"
}


resource "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = local.aks_cluster_name

  default_node_pool {
    name       = local.default_node_pool_name
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Learning"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw

  sensitive = true
}

data "azurerm_container_registry" "ctrreg" {
  name                = var.container_registry_name
  resource_group_name = var.container_registry_rg_name
}

resource "azurerm_role_assignment" "example" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.ctrreg.id
  skip_service_principal_aad_check = true
}
