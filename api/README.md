
# Azure Modern Apps - API Reference

## Introduction

These example APIs are based on the Australian Government's Consumer Data Right (CDR) legislation (specifically the Banking APIs).

The CDR reference documentation can be found here: https://consumerdatastandardsaustralia.github.io/standards

## Pre-requisities

Please ensure the following pre-requisities are installed and configured in order to develop and run the APIs on a local development environment.

* .NET Core 3.1 (https://dotnet.microsoft.com/download/dotnet-core/3.1)
* Azure Functions Core Tools (https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local)
* Visual Studio 2019 (optional)

## Projects

**BankingApi** - Azure Function App project for the Banking API

**BankingApi.Data** - Contains the Entity Framework Core data context

**BankingApi.Model** - Contains the database model classes

**BankingApi.Test** - Unit test project for hte Banking API

## Core Concepts

### Managed Identities

The Azure Function Apps access Azure Key Vault via Managed Identities (see https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview)
