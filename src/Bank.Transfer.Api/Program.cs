using Bank.Transfer.Api.Application.Abstractions;
using Bank.Transfer.Api.Infrastructure;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddDbContext<ApplicationDbContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("Database"));
});

builder.Services.AddScoped<IApplicationDbContext, ApplicationDbContext>();

var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseHttpsRedirection();


app.MapGet("/transfer", async ([FromServices] IApplicationDbContext context) =>
{
    var data = await context.Transfer.ToListAsync();
    return data;
});

app.Run();

