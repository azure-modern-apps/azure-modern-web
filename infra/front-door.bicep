param applicationName string
param apimHostname string

resource frontDoorResource 'Microsoft.Cdn/profiles@2020-09-01' = {
  name: 'fd-${applicationName}'
  location: 'Global'
  sku: {
    name: 'Standard_AzureFrontDoor'
  }
  kind: 'frontdoor'
}

resource frontDoorEndpoint 'Microsoft.Cdn/profiles/afdEndpoints@2020-09-01' = {
  name: '${frontDoorResource.name}/${applicationName}'
  location: 'Global'
}

resource frontDoorDefaultOriginGroup 'Microsoft.Cdn/profiles/originGroups@2020-09-01' = {
  name: '${frontDoorResource.name}/default-origin-group'
}

resource frontDoorDefaultOrigin 'Microsoft.Cdn/profiles/originGroups/origins@2020-09-01' = {
  name: '${frontDoorDefaultOriginGroup.name}/default-origin'
  properties: {
    hostName: apimHostname
    originHostHeader: apimHostname
  }
}

resource frontDoorDefaultRoute 'Microsoft.Cdn/profiles/afdEndpoints/routes@2020-09-01' = {
  name: '${frontDoorEndpoint.name}/default-route'
  properties: {
    originGroup: {
      id: frontDoorDefaultOriginGroup.id
    }
    linkToDefaultDomain: 'Enabled'
  }
}