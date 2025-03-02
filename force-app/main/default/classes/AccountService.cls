public class AccountService {

    public static void updateAccountTrigger(List<Order> orders) {
       

        ///if activated je somme le total du total actuel!!!!
      // Récupération des comptes liés aux commandes
        List<Account> accounts = new List<Account>();
        for (Order order : orders) {
            if (order.Status == 'Activated') {
                    accounts.add(new Account(Id = order.AccountId));
                }
        }

           

    // Mise à jour des comptes, mais seulement si aucune erreur n'a été rencontrée
    try { updateAccountBatch(accounts);
        //update accountsToUpdate;
    } catch (DmlException e) {
        // Gestion d'erreurs lors de la mise à jour
        System.debug('Erreur lors de la mise à jour des comptes : ' + e.getMessage());
    }
    }


    public static void updateAccountBatch(List<Account> accounts) {
        
   
  List<Account> accountsToUpdate=new List<Account>();
      // Récupération du total des montants par compte via OrderSelector
      Map<Id, Decimal> totalAmountByAccount = OrderSelector.getTotalAmountByAccount(accounts);
  
      // Mise à jour du chiffre d'affaires des comptes
      for (Id accountId : totalAmountByAccount.keySet()) {
        accountsToUpdate.add(new Account(Id=accountId,Chiffre_d_affaire__c=totalAmountByAccount.get(accountId)));//boucle sur la sortir 'accounts' recupere valeur dans totalAmountByAccount
        
      }
  
      // Mise à jour des comptes, mais seulement si aucune erreur n'a été rencontrée
      try {
          update accountsToUpdate;
      } catch (DmlException e) {
          // Gestion d'erreurs lors de la mise à jour
          System.debug('Erreur lors de la mise à jour des comptes : ' + e.getMessage());
      }
      }


}