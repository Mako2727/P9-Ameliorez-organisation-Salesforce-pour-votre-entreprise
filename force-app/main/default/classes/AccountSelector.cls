public class AccountSelector {

    public static Map<Id, Account> getAccount(Set<Id> orderIds) {
        Map<Id, Account> mapAccounts = new Map<Id, Account>();    
        Set<Id> accountIds = new Set<Id>(); // Stocker uniquement les IDs des comptes
    
        // Récupérer les AccountId des commandes passées en paramètre
        for (Order ord : [SELECT AccountId FROM Order WHERE Id IN :orderIds and Status='Activated' WITH SECURITY_ENFORCED ]) {
            if (ord.AccountId != null) {
                accountIds.add(ord.AccountId);
            }
        }    
        // Récupérer les comptes associés si des AccountIds existent
        if (!accountIds.isEmpty()) {
            mapAccounts.putAll(new Map<Id, Account>(
                [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :accountIds]
            ));
        }
    
        return mapAccounts;
    }
public static Database.QueryLocator getAccountsWithActivatedOrder()
{
    //probablement rajouter de champs en fonction des erreurs!!!
  return  Database.getQueryLocator('SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = \'Activated\') WITH SECURITY_ENFORCED' );

}

}