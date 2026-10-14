using Microsoft.EntityFrameworkCore;

namespace Bank.Balance.Api.Application.Abstractions;

public interface IApplicationDbContext
{
    DbSet<Domain.Balance.Balance> Balance { get; set; }

    Task<bool> SaveChangesAsync(CancellationToken cancellationToken = default);

}