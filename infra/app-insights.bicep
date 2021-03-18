param applicationName string

resource appInsights 'Microsoft.Insights/components@2018-05-01-preview' = {
  name: 'plan-${applicationName}'
  location: resourceGroup().location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    // publicNetworkAccessForIngestion: 'Enabled'
    // publicNetworkAccessForQuery: 'Enabled'
    // Flow_Type: 'Bluefield'
    // Request_Source: 'rest'
  }
}

output appInsightsInstrumentationKey string = appInsights.properties.InstrumentationKey