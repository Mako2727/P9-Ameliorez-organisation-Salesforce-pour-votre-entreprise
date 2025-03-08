public with sharing class OrderSelector {
  public static Map<Id, Decimal> getTotalAmountByAccount(
    List<Account> accounts
  ) {
    Map<Id, Decimal> totalAmountByAccount = new Map<Id, Decimal>();

    for (AggregateResult result : [
      SELECT AccountId, SUM(TotalAmount) totalAmount
      FROM Order
      WHERE AccountId IN :accounts AND Status = 'Activated'
      WITH SECURITY_ENFORCED
      GROUP BY AccountId
    ]) {
      Id accountId = (Id) result.get('AccountId');
      Decimal totalAmount = (Decimal) result.get('totalAmount');

      totalAmountByAccount.put(accountId, totalAmount);
    }
    return totalAmountByAccount;
  }

  public static Decimal getSumTotalAmount(Id accountId) {
    AggregateResult groupedResults = [
      SELECT SUM(TotalAmount) total
      FROM Order
      WHERE AccountId = :accountId AND Status = 'Activated'
      WITH SECURITY_ENFORCED
    ];

    return (Decimal) groupedResults.get('total');
  }
}
