using Bank.Gateway.Api.Application;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Mvc;

namespace Bank.Gateway.Api.Api
{
    public static class ApiGatewayEndpoint
    {
        public static void GatewayEndpoint(WebApplication app)
        {
            app.MapPost("/api-gateway", ([FromBody] EndpointModel model) =>
            {
                return model;
            });
        }
    }
}
