using Bank.Gateway.Api.Api;
using Microsoft.AspNetCore.Builder;

var builder = WebApplication.CreateBuilder(args);


var app = builder.Build();

ApiGatewayEndpoint.GatewayEndpoint(app);

app.Run();
