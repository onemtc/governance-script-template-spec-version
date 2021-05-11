param aspName string
param loc string

resource asp 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: aspName
  location: loc
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
