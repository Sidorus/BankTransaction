using Microsoft.EntityFrameworkCore;

namespace Bank.Transaction.Api.Application.Abstractions;

public interface IApplicationDbContext
{
    DbSet<Domain.Transaction.Transaction> Transaction { get; set; }

    Task<bool> SaveChangesAsync(CancellationToken cancellationToken = default);
}