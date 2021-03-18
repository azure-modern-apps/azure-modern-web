param applicationName string
param objectId string
param location string

var secretsAllowArray = [
  'get'
  'set'
  'list'
  'delete'
]

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: 'kv-${applicationName}'
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      name: 'standard'
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