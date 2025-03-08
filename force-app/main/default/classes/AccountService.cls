public with sharing class AccountService {
  public static void updateAccountCaActivated(List<Order> orders) {
    List<Account> accounts = new List<Account>();
    if (Order.getSObjectType().getDescribe().isUpdateable()) {
      for (Order order : orders) {
        if (order.Status == 'Activated') {
          accounts.add(new Account(Id = order.AccountId));
        }
      }
      try {
        updateAccountCa(accounts);
      } catch (DmlException e) {
        System.debug(
          'Erreur lors de la mise à jour des comptes : ' + e.getMessage()
        );
      }
    }
  }

  public static void updateAccountCa(List<Account> accounts) {
    List<Account> accountsToUpdate = new List<Account>();

    if (Account.getSObjectType().getDescribe().isUpdateable()) {
      // Récupération du total des montants par compte via OrderSelector
      Map<Id, Decimal> totalAmountByAccount = OrderSelector.getTotalAmountByAccount(
        accounts
      );

      // Mise à jour du chiffre d'affaires des comptes
      for (Id accountId : totalAmountByAccount.keySet()) {
        accountsToUpdate.add(
          new Account(
            Id = accountId,
            Chiffre_d_affaire__c = totalAmountByAccount.get(accountId)
          )
        );
      }
      try {
        update accountsToUpdate;
      } catch (DmlException e) {
        // Gestion d'erreurs lors de la mise à jour
        System.debug(
          'Erreur lors de la mise à jour des comptes : ' + e.getMessage()
        );
      }
    }
  }
}
