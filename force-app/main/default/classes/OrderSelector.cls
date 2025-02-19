public class OrderSelector {

    public static Map<Id, Decimal> getTotalAmountByAccount(Set<Id> orderIds) {
        Map<Id, Decimal> totalAmountByAccount = new Map<Id, Decimal>();

        for (AggregateResult result : [
            SELECT AccountId, SUM(TotalAmount) totalAmount 
            FROM Order 
            WHERE Id IN :orderIds 
            GROUP BY AccountId
        ]) {
            Id accountId = (Id) result.get('AccountId');
            Decimal totalAmount = (Decimal) result.get('totalAmount');

            totalAmountByAccount.put(accountId, totalAmount);
        }

        return totalAmountByAccount;
    }


    public static Database.QueryLocator getAllOrder()
    {
        return Database.getQueryLocator('SELECT Id from Order WITH SECURITY_ENFORCED');

    }


    public static Decimal getSumTotalAmount(Id orderId)
    {
        AggregateResult groupedResults = [
            SELECT SUM(TotalAmount) total 
            FROM Order 
            WHERE Id = :orderId AND Status = 'Activated' 
        ];
        
        return  (groupedResults.get('total') != null) ? (Decimal) groupedResults.get('total') : 0;

    }

}