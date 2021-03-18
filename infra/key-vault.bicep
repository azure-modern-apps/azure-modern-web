param applicationName string
param objectId string
param skuName string = 'standard'

var secretsAllowArray = [
  'get'
  'set'
  'list'
  'delete'
]

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: 'kv-${applicationName}'
  location: resourceGroup().location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      name: skuName
      family: 'A'
    }
    accessPolicies: [
      {
        objectId: objectId
        tenantId: subscription().tenantId
        permissions: {
          secrets: secretsAllowArray
        }
      }
    ]
  }
}

output keyVaultName string = keyVault.name