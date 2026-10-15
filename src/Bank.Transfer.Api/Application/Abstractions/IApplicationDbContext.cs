using System.Threading;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace Bank.Transfer.Api.Application.Abstractions;

public interface IApplicationDbContext                  
{
    DbSet<Domain.Transfer.Transfer> Transfer { get; set; }

    Task<bool> SaveChangesAsync(CancellationToken cancellationToken = default);

}