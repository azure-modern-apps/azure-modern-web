using System;
using Azure.Identity;
using BankingApi;
using BankingApi.Data;
using Microsoft.Azure.Functions.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

[assembly: FunctionsStartup(typeof(Startup))]

namespace BankingApi
{
    public class Startup : FunctionsStartup
    {
        public override void Configure(IFunctionsHostBuilder builder)
        {
            var configuration = builder.GetContext().Configuration;

            ConfigureServices(builder.Services, configuration);
        }

        public void ConfigureServices(IServiceCollection services, IConfiguration configuration)
        {
            services.AddDbContext<BankingContext>(options =>
                options.UseCosmos(
                    configuration["CosmosEndpoint"],
                    configuration["CosmosAccountKey"],
                    configuration["CosmosDatabaseName"]));
        }

        public override void ConfigureAppConfiguration(IFunctionsConfigurationBuilder builder)
        {
            var vaultUri = new Uri(Environment.GetEnvironmentVariable("KeyVaultUri") ?? throw new InvalidOperationException());
            var vaultTenantId = Environment.GetEnvironmentVariable("KeyVaultTenantId");

            var azureCredential = new DefaultAzureCredential(new DefaultAzureCredentialOptions
            {
                ExcludeSharedTokenCacheCredential = true,
                VisualStudioTenantId = vaultTenantId
            });

            builder.ConfigurationBuilder.AddAzureKeyVault(vaultUri, azureCredential);
        }
    }
}