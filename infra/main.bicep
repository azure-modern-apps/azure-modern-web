param objectId string
param applicationName string

param publisherEmail string = 'duhunter@microsoft.com'
param publisherName string = 'Duncan Hunter'
param cosmosDatabaseName string = 'BankingDatabase'

targetScope = 'subscription'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: deployment().name
  location: deployment().location
}

module apiManagement 'api-management.bicep' = {
  name: 'apiManagementDeploy'
  scope: resourceGroup
  params: {
    publisherEmail: publisherEmail
    publisherName: publisherName
    applicationName: applicationName
  }
}

module frontDoor 'front-door.bicep' = {
  name: 'frontDoorDeployment'
  scope: resourceGroup
  params: {
    applicationName: applicationName
    apimHostname: apiManagement.outputs.apimHostname
  }
}

module cosmosdb 'cosmos-db.bicep' = {
  name: 'cosmosDbDeployment'
  scope: resourceGroup
  params: {
    applicationName: applicationName
    cosmosDatabaseName: cosmosDatabaseName
    keyVaultName: keyVault.outputs.keyVaultName
  }
}

module storageAccount 'storage-account.bicep' = {
  name: 'storageAccountDeployment'
  scope: resourceGroup
  params: {
    applicationName: applicationName
    keyVaultName: keyVault.outputs.keyVaultName
  }
}

module keyVault 'key-vault.bicep' = {
  name: 'keyVaultDeployment'
  scope: resourceGroup
  params: {
    applicationName: applicationName
    objectId: objectId
  }
}

module functionApp 'function-app.bicep' = {
  name: 'functionAppDeployment'
  scope: resourceGroup
  params: {
    appInsightsInstrumentationKey: appInsights.outputs.appInsightsInstrumentationKey
    applicationName: applicationName
    keyVaultName: keyVault.outputs.keyVaultName
    storageAccount: storageAccount.outputs.storageAccount
    planId: appServicePlan.outputs.planId
  }
}

module appServicePlan 'app-service-plan.bicep' = {
name: 'planDeployment'
  scope: resourceGroup
  params: {
    applicationName: applicationName
  }
}

module appInsights 'app-insights.bicep' = {
  name: 'appInsightsDeployment'
  scope: resourceGroup
  params: {
    applicationName: applicationName
  }
}