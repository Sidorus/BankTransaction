namespace Bank.Balance.Api.Domain.Balance
{
    public class Balance
    {
        public int Id { get; set; }

        public string CorrelationId { get; set; }

        public DateTime BalanceDate { get; set; }

        public string CurrentState { get; set; }

        public string CustomerId { get; set; }


    }
}
