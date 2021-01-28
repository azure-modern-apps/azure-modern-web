using System;

namespace BankingApi.Model
{
    public class Product
    {
        public Guid Id { get; set; }

        public DateTime EffectiveFromDate { get; set; }
        public DateTime EffectiveToDate { get; set; }

        public string Name { get; set; }
        public string Description { get; set; }

        public string Category { get; set; }

        public DateTime LastUpdated { get; set; }
    }
}
