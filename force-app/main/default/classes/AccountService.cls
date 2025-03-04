public class AccountService {

    public static void updateAccountTrigger(List<Order> orders) {
    List<Account> accounts = new List<Account>();
    if (Order.getSObjectType().getDescribe().isUpdateable()) {
              for (Order order : orders) {
                    if (order.Status == 'Activated') {
                    accounts.add(new Account(Id = order.AccountId));
                    }
                }   
        try { 
            updateAccountBatch(accounts);            
        } 
        catch (DmlException e) {           
            System.debug('Erreur lors de la mise à jour des comptes : ' + e.getMessage());
        }
    }
    }


    public static void updateAccountBatch(List<Account> accounts) {  
    List<Account> accountsToUpdate=new List<Account>();
    System.debug('Debut de l update pour updateAccountBatch');
       if (Account.getSObjectType().getDescribe().isUpdateable()) {
            // Récupération du total des montants par compte via OrderSelector
            Map<Id, Decimal> totalAmountByAccount = OrderSelector.getTotalAmountByAccount(accounts);
        
            // Mise à jour du chiffre d'affaires des comptes
            for (Id accountId : totalAmountByAccount.keySet()) {
                accountsToUpdate.add(new Account(Id=accountId,Chiffre_d_affaire__c=totalAmountByAccount.get(accountId)));
            }   
            try {
                    update accountsToUpdate;
            } catch (DmlException e) {
                // Gestion d'erreurs lors de la mise à jour
                System.debug('Erreur lors de la mise à jour des comptes : ' + e.getMessage());
            }
        }
     System.debug('Fin de l update pour updateAccountBatch');
      }


}