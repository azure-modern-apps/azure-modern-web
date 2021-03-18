param objectId string
param applicationName string
param location string
param publisherEmail string = 'duhunter@microsoft.com'
param publisherName string = 'Duncan Hunter'
param cosmosDatabaseName string = 'BankingDatabase'

module apiManagement 'api-management.bicep' = {
  name: 'apiManagementDeploy'
  params: {
    applicationName: applicationName
    location: location
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}

module frontDoor 'front-door.bicep' = {
  name: 'frontDoorDeployment'
  params: {
    applicationName: applicationName
    apimHostname: apiManagement.outputs.apimHostname
  }
}

module cosmosdb 'cosmos-db.bicep' = {
  name: 'cosmosDbDeployment'
  params: {
    applicationName: applicationName
    location: location
    cosmosDatabaseName: cosmosDatabaseName
    keyVaultName: keyVault.outputs.keyVaultName
  }
}

module storageAccount 'storage-account.bicep' = {
  name: 'storageAccountDeployment'
  params: {
    applicationName: applicationName
    location: location
    keyVaultName: keyVault.outputs.keyVaultName
  }
}

module keyVault 'key-vault.bicep' = {
  name: 'keyVaultDeployment'
  params: {
    applicationName: applicationName
    location: location
    objectId: objectId
  }
}

module functionApp 'function-app.bicep' = {
  name: 'functionAppDeployment'
  params: {
    applicationName: applicationName
    location: location
    appInsightsInstrumentationKey: appInsights.outputs.appInsightsInstrumentationKey
    keyVaultName: keyVault.outputs.keyVaultName
    storageAccount: storageAccount.outputs.storageAccount
    planId: appServicePlan.outputs.planId
  }
}

module appServicePlan 'app-service-plan.bicep' = {
  name: 'planDeployment'
  params: {
    applicationName: applicationName
    location: location
  }
}

module appInsights 'app-insights.bicep' = {
  name: 'appInsightsDeployment'
  params: {
    applicationName: applicationName
    location: location
  }
}