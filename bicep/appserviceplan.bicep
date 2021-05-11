param aspName string

resource asp 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: aspName
  location: resourceGroup().location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
  properties: {
    targetWorkerCount: 1
    targetWorkerSizeId: 0
    reserved: false
  }
}
