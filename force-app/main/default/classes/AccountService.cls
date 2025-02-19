public class AccountService {

    public static void updateAccount(Set<Id> orderIds) {

      // Récupération des comptes liés aux commandes
    Map<Id, Account> accountsToUpdate = AccountSelector.getAccount(orderIds);

    // Récupération du total des montants par compte via OrderSelector
    Map<Id, Decimal> totalAmountByAccount = OrderSelector.getTotalAmountByAccount(orderIds);

    // Mise à jour du chiffre d'affaires des comptes
    for (Id accountId : totalAmountByAccount.keySet()) {
        if (accountsToUpdate.containsKey(accountId)) {
            Account acc = accountsToUpdate.get(accountId);
            try {
                // Réinitialiser le chiffre d'affaires et ajouter la nouvelle valeur
                Decimal newRevenue = totalAmountByAccount.get(accountId);
                // Si on veut additionner un montant sur un chiffre d'affaire existant
                acc.Chiffre_d_affaire__c =  newRevenue;
            } catch (Exception e) {
                // Ajout d'une erreur sur l'Account en cas de problème
                acc.addError('Erreur lors de la mise à jour du Chiffre d\'affaire : ' + e.getMessage());
            }
        }
    }

    // Mise à jour des comptes, mais seulement si aucune erreur n'a été rencontrée
    try {
        update accountsToUpdate.values();
    } catch (DmlException e) {
        // Gestion d'erreurs lors de la mise à jour
        System.debug('Erreur lors de la mise à jour des comptes : ' + e.getMessage());
    }
    }


    public static void updateAccountBatch(Set<Id> orderIds) {
        
        // Récupération des comptes liés aux commandes
      Map<Id, Account> accountsToUpdate = AccountSelector.getAllAccount();
  
      // Récupération du total des montants par compte via OrderSelector
      Map<Id, Decimal> totalAmountByAccount = OrderSelector.getTotalAmountByAccount(orderIds);
  
      // Mise à jour du chiffre d'affaires des comptes
      for (Id accountId : totalAmountByAccount.keySet()) {
          if (accountsToUpdate.containsKey(accountId)) {
              Account acc = accountsToUpdate.get(accountId);
              try {
                  // Réinitialiser le chiffre d'affaires et ajouter la nouvelle valeur
                  Decimal newRevenue = totalAmountByAccount.get(accountId);
                  // Si on veut additionner un montant sur un chiffre d'affaire existant
                  acc.Chiffre_d_affaire__c =  newRevenue;
              } catch (Exception e) {
                  // Ajout d'une erreur sur l'Account en cas de problème
                  acc.addError('Erreur lors de la mise à jour du Chiffre d\'affaire : ' + e.getMessage());
              }
          }
      }
  
      // Mise à jour des comptes, mais seulement si aucune erreur n'a été rencontrée
      try {
          update accountsToUpdate.values();
      } catch (DmlException e) {
          // Gestion d'erreurs lors de la mise à jour
          System.debug('Erreur lors de la mise à jour des comptes : ' + e.getMessage());
      }
      }


}