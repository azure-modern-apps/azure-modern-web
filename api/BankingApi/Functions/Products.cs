using System;
using System.Linq;
using System.Threading.Tasks;
using BankingApi.Data;
using BankingApi.Response;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace BankingApi.Functions
{
    public class Products
    {
        private readonly BankingContext _context;

        public Products(BankingContext context)
        {
            _context = context;
        }

        [FunctionName("products")]
        public async Task<IActionResult> Run([HttpTrigger(AuthorizationLevel.Function, "get", Route = "banking/products")] HttpRequest req, ILogger log)
        {
            try
            {
                await _context.Database.EnsureDeletedAsync();
                await _context.Database.EnsureCreatedAsync();

                var products = await _context.Products.ToListAsync();

                var response = products.Select(product => new ProductResponse
                    {
                        EffectiveFromDate = product.EffectiveFromDate,
                        EffectiveToDate = product.EffectiveToDate,
                        Name = product.Name,
                        Description = product.Description,
                        Category = product.Category,
                        LastUpdated = product.LastUpdated
                    })
                    .ToList();

                var responseMessage = JsonConvert.SerializeObject(response);

                return new OkObjectResult(responseMessage);
            }
            catch (Exception e)
            {
                log.LogInformation($"Exception thrown in {req.Path}: {e}");

                throw;
            }
           
        }
    }
}