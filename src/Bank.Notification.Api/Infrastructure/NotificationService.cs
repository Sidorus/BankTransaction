using System.Reflection.Metadata;
using Bank.Notification.Api.Application.Abstractions;
using Microsoft.Azure.Cosmos;
using Microsoft.Azure.Cosmos.Linq;
using Microsoft.Extensions.Configuration;


namespace Bank.Notification.Api.Infrastructure
{
    public class NotificationService : INotificationService
    {
        private readonly CosmosClient cosmosClient;
        private readonly Container container;

        public NotificationService(IConfiguration configuration)
        {
            cosmosClient = new CosmosClient(configuration["Cosmos:ConnectionString"]);
            container = cosmosClient.GetContainer(configuration["Cosmos:DatabaseName"],
                configuration["Cosmos:ContainerName"]);
        }

        public async Task<bool> AddAsync(Domain.Notification.Notification notification)
        {
            notification.Id = Guid.NewGuid().ToString();
            notification.NotificationDate = DateTime.UtcNow;

            var response = await container.CreateItemAsync(notification, new PartitionKey(notification.CorrelationId));
            if (response.StatusCode == System.Net.HttpStatusCode.Created)
            {
                return true;
            }

            return false;
        }

        public async Task<List<Domain.Notification.Notification>> GetAllAsync()
        {
            var notifications = new List<Domain.Notification.Notification>();
            var query = new QueryDefinition("SELECT * FROM c");
            var iterator = container.GetItemQueryIterator<Domain.Notification.Notification>(query);

            while (iterator.HasMoreResults)
            {
                var response = await iterator.ReadNextAsync();
                notifications.AddRange(response);
            }

            return notifications;
        }
    }
}


