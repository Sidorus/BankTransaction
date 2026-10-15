using Bank.Balance.Api.Application.Abstractions;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;

namespace Bank.Balance.Api.Infrastructure
{
    public class ApplicationDbContext : DbContext , IApplicationDbContext
    {
        public ApplicationDbContext(DbContextOptions options)
            : base(options)
        {
          
        }

        public DbSet<Domain.Balance.Balance> Balance { get; set; }

        public async Task<bool> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            return await base.SaveChangesAsync(cancellationToken) > 0;
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        }
    }
}
