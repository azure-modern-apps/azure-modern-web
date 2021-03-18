param applicationName string
param location string

resource appInsights 'Microsoft.Insights/components@2018-05-01-preview' = {
  name: 'plan-${applicationName}'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

output appInsightsInstrumentationKey string = appInsights.properties.InstrumentationKey