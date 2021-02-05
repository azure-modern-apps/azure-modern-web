# Deployment considerations
- in the same way that composability is important when writing code - we avoid having one massive deployment workflow and instead decompose our deployment workflows into sensible chunks.

# Steps to setup GitHub Actions
For an introduction to GitHub Actions check out the [GitHub Actions Quick Start](https://docs.github.com/en/actions/quickstart) and the [Introduction to GitHub Actions](https://docs.github.com/en/actions/learn-github-actions/introduction-to-github-actions)


### Step 1: Create the resource group (or get the resource group ID)

#### Option 1: Create a new Resource Group using the CLI (Preferred)
for more detail - [See the doco for this section](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-github-actions)

The benefit of creating the Resource Group from the CLI is that the Resource Group and SubscriptionID are returned from the command.

Execute the following in Azure Cloud Shell, or locally in the Azure CLI

```
az group create --name {MyResourceGroup} --location {TargetRegion}
```

Replace the following
- {MyResourceGroup} with the name of the resource group
- {TargetRegion} with the code for the target region. e.g. australiaeast . Use ```az account list-locations -o table``` to list all regions

#### Option 2: Use an Existing Resource group
- get the resource group name
Open the Resource Group in the Azure Portal and copy down the Subscription ID and the Resource Group name from the Overview tab



### Step 1: Configure Deployment Credentials
(For more detail - [See the doco for this section](https://github.com/Azure/login#configure-deployment-credentials'))

Execute the following in Azure Cloud Shell

```
az ad sp create-for-rbac --name "{sp-name}" --sdk-auth --role contributor \
    --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group}
```

Replace the following:
- {sp-name} with a suitable name for your service principal, such as the name of the app itself. The name must be unique within your organization.
- {subscription-id} with the subscription you want to use
- {resource-group} the resource group containing the web app.

 
### Step 1. Setup a service principal



(Source: https://github.com/Azure/login#configure-deployment-credentials')

