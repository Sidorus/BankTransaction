using Bank.Notification.Api.Application.Abstractions;
using Bank.Notification.Api.Infrastructure;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Mvc;
using NotificationEntity = Bank.Notification.Api.Domain.Notification.Notification;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddScoped<INotificationService, NotificationService>();

var app = builder.Build();

// Configure the HTTP request pipeline.


app.MapGet("/notification", async ([FromServices] INotificationService notificationService) =>
{
    var entity = new NotificationEntity
    {
        CorrelationId = Guid.NewGuid().ToString(),
        Content = "mensaje de prueba",
        TransactionState = "true",
        Type = "email",
        CustomerId = "1"
    };

    await notificationService.AddAsync(entity);

    var data = await notificationService.GetAllAsync();
    return data;
});

app.Run();


