param publisherEmail string
param publisherName string
param applicationName string

resource apiManagement 'Microsoft.ApiManagement/service@2019-12-01' = {
  name: 'apim-${applicationName}'
  location: resourceGroup().location
  sku: {
    name: 'Consumption'
    capacity: 0
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
    // customProperties: {
    //   'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10': 'False'
    //   'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11': 'False'
    //   'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10': 'False'
    //   'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11': 'False'
    //   'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30': 'False'
    //   'Microsoft.WindowsAzure.ApiManagement.Gateway.Protocols.Server.Http2': 'False'
    // }
  }
  identity: {
    type: 'SystemAssigned'
  }
}

output apimHostname string = apiManagement.properties.hostnameConfigurations[0].hostName