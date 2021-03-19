param applicationName string
param cosmosDatabaseName string
param keyVaultName string

resource cosmosDb 'Microsoft.DocumentDB/databaseAccounts@2020-06-01-preview' = {
  name: 'cosmos-${applicationName}'
  location: resourceGroup().location
  kind: 'GlobalDocumentDB'
  properties: {
    createMode: 'Default'
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: [
      {
        locationName: resourceGroup().location
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    databaseAccountOfferType: 'Standard'
  }
}

resource cosmosDbDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2020-06-01-preview' = {
  name: '${cosmosDb.name}/${cosmosDatabaseName}'
  properties: {
    resource: {
      id: cosmosDatabaseName
    }
    options: {
      throughput: 400
    }
  }
}

resource cosmosDbKeySecret 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
  name: '${keyVaultName}/CosmosDbKey'
  properties: {
    value: listKeys(cosmosDb.id, cosmosDb.apiVersion).primaryMasterKey
  }
}