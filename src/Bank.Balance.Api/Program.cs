using Bank.Balance.Api.Application.Abstractions;
using Bank.Balance.Api.Infrastructure;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddDbContext<Bank.Balance.Api.Infrastructure.ApplicationDbContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("Database"));
});

builder.Services.AddScoped<IApplicationDbContext, ApplicationDbContext>();

var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseHttpsRedirection();


app.MapGet("/balance", async ([FromServices] IApplicationDbContext context) =>
{
    var data = await context.Balance.ToListAsync();
    return data;
});

app.Run();


