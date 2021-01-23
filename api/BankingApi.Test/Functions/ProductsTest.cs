using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using BankingApi.Response;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Newtonsoft.Json;

namespace BankingApi.Test.Functions
{
    [TestClass]
    public class ProductsTest : TestBase
    {
        [TestMethod]
        public async Task Get_ReturnsProducts()
        {
            var func = new BankingApi.Functions.Products(CreateDbContext());
            var response = (OkObjectResult)await func.Run(CreateHttpRequest(), Factory.CreateLogger<BankingApi.Functions.Products>());
            var responseBody = JsonConvert.DeserializeObject<IList<ProductResponse>>(response.Value.ToString());

            Assert.IsTrue(response.StatusCode == (int)HttpStatusCode.OK);
            Assert.AreEqual(3, responseBody.Count);
        }
    }
}