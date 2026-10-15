using System;
using Newtonsoft.Json;

namespace Bank.Notification.Api.Domain.Notification
{
    public class Notification
    {
        [JsonProperty("id")]
        public string Id { get; set; }

        [JsonProperty("correlationId")]
        public string CorrelationId { get; set; }

        [JsonProperty("notificationDate")]

        public DateTime NotificationDate { get; set; }

        [JsonProperty("type")]  
        public string Type { get; set; }

        [JsonProperty("content")]

        public string Content { get; set; }

        [JsonProperty("transactionState")]
        public string TransactionState { get; set; }

        [JsonProperty("customerId")] 
        public string CustomerId { get; set; }


    }
}
