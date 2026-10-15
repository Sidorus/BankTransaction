using System;

namespace Bank.Transfer.Api.Domain.Transfer
{
    public class Transfer
    {
        public int Id { get; set; }

        public string CorrelationId { get; set; }

        public DateTime TransferDate { get; set; }

        public string CurrentState { get; set; }

        public decimal Amount { get; set; }

        public string SourceAccount { get; set; }

        public string DestinationAccount { get; set; }

        public string CustomerId { get; set; }


    }
}
