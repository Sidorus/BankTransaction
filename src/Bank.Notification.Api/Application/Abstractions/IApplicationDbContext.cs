namespace Bank.Notification.Api.Application.Abstractions;

public interface INotificationService
{
    Task<bool> AddAsync(Domain.Notification.Notification notification);

    Task<List<Domain.Notification.Notification>> GetAllAsync();

}