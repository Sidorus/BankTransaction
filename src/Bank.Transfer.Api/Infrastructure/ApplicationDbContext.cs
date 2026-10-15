using System.Threading;
using System.Threading.Tasks;
using Bank.Transfer.Api.Application.Abstractions;
using Microsoft.EntityFrameworkCore;

namespace Bank.Transfer.Api.Infrastructure
{
    public class ApplicationDbContext : DbContext , IApplicationDbContext
    {
        public ApplicationDbContext(DbContextOptions options)
            : base(options)
        {
          
        }

        public DbSet<Domain.Transfer.Transfer> Transfer { get; set; }

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
