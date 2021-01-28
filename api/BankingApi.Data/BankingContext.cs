using System;
using BankingApi.Model;
using Microsoft.EntityFrameworkCore;

namespace BankingApi.Data
{
    public class BankingContext : DbContext
    {
        public BankingContext(DbContextOptions<BankingContext> options) : base(options)
        {
            
        }

        public DbSet<Product> Products { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.HasDefaultContainer("Banking");

            modelBuilder.Entity<Product>().HasData(
                new Product { Id = Guid.Parse("9F71BD32-28E9-4FA8-A25D-981DB54A4C97"), EffectiveFromDate = DateTime.MinValue, EffectiveToDate = DateTime.MaxValue, Name = "Transaction Account", Description = "Transaction Account", Category = ProductCategory.TransactionAndSavingsAccount.ToString(), LastUpdated = DateTime.MinValue },
                new Product { Id = Guid.Parse("BED3B814-4FFF-47E9-88F3-FCB78B7474E0"), EffectiveFromDate = DateTime.MinValue, EffectiveToDate = DateTime.MaxValue, Name = "Savings Account", Description = "Savings Account", Category = ProductCategory.TransactionAndSavingsAccount.ToString(), LastUpdated = DateTime.MinValue },
                new Product { Id = Guid.Parse("60164D00-5566-4931-B286-E999162A1750"), EffectiveFromDate = DateTime.MinValue, EffectiveToDate = DateTime.MaxValue, Name = "Joint Account", Description = "Joint Account", Category = ProductCategory.TransactionAndSavingsAccount.ToString(), LastUpdated = DateTime.MinValue }
            );
        }
    }
}