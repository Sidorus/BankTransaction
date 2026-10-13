using Bank.Transaction.Api.Application.Abstractions;
using Bank.Transaction.Api.Infrastructure;
using Microsoft.AspNetCore.Builder;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.



builder.Services.AddDbContext<Bank.Transaction.Api.Infrastructure.ApplicationDbContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("Database"));
});

builder.Services.AddScoped<IApplicationDbContext, ApplicationDbContext>();

var app = builder.Build();

app.UseHttpsRedirection();


app.MapGet("/transaction",async ([FromServices] IApplicationDbContext context) =>
{
    var data = await context.Transaction.ToListAsync();
    return data;
});

app.Run();

