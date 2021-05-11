targetScope = 'subscription'

param resourceGroupName string
param location string

param storageName string

resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: resourceGroupName
  location: location
}

module stgModule 'localblobstorage.bicep' = {
  name: 'stgModule'
  scope: rg
  params: {
    storageName: storageName
  }
}
