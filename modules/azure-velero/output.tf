locals {
  cloud_credentials = <<EOF
AZURE_SUBSCRIPTION_ID=${data.azurerm_client_config.main.subscription_id}
AZURE_TENANT_ID=${data.azurerm_client_config.main.tenant_id}
AZURE_CLIENT_ID=${azuread_service_principal.main.application_id}
AZURE_CLIENT_SECRET=${azuread_service_principal_password.main.value}
AZURE_RESOURCE_GROUP=${data.azurerm_resource_group.aks.name}
EOF
  backup_storage_location = <<EOF
apiVersion: velero.heptio.com/v1
kind: BackupStorageLocation
metadata:
  name: default
spec:
  provider: azure
  objectStorage:
    bucket: ${azurerm_storage_container.main.name}
  config:
    resourceGroup: ${data.azurerm_resource_group.velero.name}
    storageAccount: ${azurerm_storage_account.main.name}
EOF
  volume_snapshot_location = <<EOF
apiVersion: velero.heptio.com/v1
kind: VolumeSnapshotLocation
metadata:
  name: default
spec:
  provider: azure
  config:
    apiTimeout: 4m0s
    resouceGroup: ${data.azurerm_resource_group.velero.name}
EOF
}

output "cloud_credentials" {
  value = "${local.cloud_credentials}"
}

output "backup_storage_location" {
  value = "${local.backup_storage_location}"
}

output "volume_snapshot_location" {
  value = "${local.volume_snapshot_location}"
}