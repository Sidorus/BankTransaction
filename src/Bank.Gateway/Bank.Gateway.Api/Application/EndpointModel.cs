namespace Bank.Gateway.Api.Application
{
    public class EndpointModel
    {
        public int CustomerId { get; set; }

        public decimal Amount { get; set; }

        public string SourceAccount { get; set; }

        public string DestinationAccount { get; set; }
    }
}
