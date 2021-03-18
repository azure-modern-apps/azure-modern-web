param publisherEmail string
param publisherName string
param applicationName string
param location string

resource apiManagement 'Microsoft.ApiManagement/service@2019-12-01' = {
  name: 'apim-${applicationName}'
  location: location
  sku: {
    name: 'Consumption'
    capacity: 0
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
  identity: {
    type: 'SystemAssigned'
  }
}

output apimHostname string = apiManagement.properties.hostnameConfigurations[0].hostName