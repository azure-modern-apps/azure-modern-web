param applicationName string
param location string

resource plan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: 'plan-${applicationName}'
  location: location
  kind: 'functionapp'
  sku: {
    name: 'Y1'
  }
}

output planId string = plan.id