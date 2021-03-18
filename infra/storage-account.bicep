param applicationName string
param keyVaultName string
param location string

var storageAccountName = format('stg{0}', replace(applicationName, '-', ''))

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAccountKeySecret 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
  name: '${keyVaultName}/${storageAccount.name}Key'
  properties: {
    value: listKeys(storageAccount.id, storageAccount.apiVersion).keys[0].value
  }
}

output storageAccount object = {
  name: storageAccount.name
  id: storageAccount.id
  apiVersion: storageAccount.apiVersion
}