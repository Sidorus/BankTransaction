using Bank.Transaction.Api.Application.Abstractions;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;

namespace Bank.Transaction.Api.Infrastructure
{
    public class ApplicationDbContext : DbContext , IApplicationDbContext
    {
        public ApplicationDbContext(DbContextOptions options)
            : base(options)
        {
          
        }

        public DbSet<Domain.Transaction.Transaction> Transaction { get; set; }

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
