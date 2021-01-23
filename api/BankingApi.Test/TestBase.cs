using BankingApi.Data;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace BankingApi.Test
{
    public abstract class TestBase
    {
        protected static readonly LoggerFactory Factory = new LoggerFactory();

        public BankingContext CreateDbContext()
        {
            var optionsBuilder = new DbContextOptionsBuilder<BankingContext>();
            optionsBuilder.UseInMemoryDatabase("Banking");

            return new BankingContext(optionsBuilder.Options);
        }

        public HttpRequest CreateHttpRequest()
        {
            var context = new DefaultHttpContext();
            return context.Request;
        }
    }
}