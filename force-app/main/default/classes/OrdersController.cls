public with sharing class OrdersController {
  @AuraEnabled(cacheable=false)
  public static Decimal getSumOrdersByAccount(Id accountId) {
    Decimal TotalAmount = OrderSelector.getSumTotalAmount(accountId);
    return TotalAmount;
  }
}
