using System;

namespace BankingApi.Response
{
    public class ProductResponse
    {
        public DateTime EffectiveFromDate { get; set; }
        public DateTime EffectiveToDate { get; set; }

        public string Name { get; set; }
        public string Description { get; set; }

        public string Category { get; set; }

        public DateTime LastUpdated { get; set; }
    }
}