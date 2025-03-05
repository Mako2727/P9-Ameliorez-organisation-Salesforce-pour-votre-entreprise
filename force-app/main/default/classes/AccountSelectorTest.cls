@IsTest
private class AccountSelectorTest {

    @TestSetup
    static void setup() {
      TestDataFactory.createTestgetAccount();
    }

    @IsTest 
    static void testgetAccount(){

         // Récupérer les Orders déjà insérés via la classe de setup
         Set<Id> orderIds = new Set<Id>();
         for (Order ord : [SELECT Id FROM Order where Status = 'Activated']) {
             orderIds.add(ord.Id);
         }
         
         // Vérifier qu'on a bien des commandes à tester
         System.assert(orderIds.size() > 0, 'Il doit y avoir au moins une commande pour exécuter le test.');
 
         // Lancer la méthode getAccount
         Test.startTest();
         Map<Id, Account> accountMap = AccountSelector.getAccount(orderIds);
         Test.stopTest();
 
         // Vérifications sur le résultat retourné
         System.assertNotEquals(null, accountMap, 'Le résultat ne doit pas être nul');
         System.assert(accountMap.size() > 0, 'La Map retournée doit contenir des comptes.');
         
         for (Id accId : accountMap.keySet()) {
             System.assertNotEquals(null, accountMap.get(accId), 'Chaque compte dans la map doit être non nul');
         }
    }


    @IsTest 
    static void testgetAccountsWithActivatedOrder(){        
          Test.startTest();
          Database.QueryLocator locatorAccounts = AccountSelector.getAccountsWithActivatedOrder(); 
          List<Account> accounts = new List<Account>();
          for (SObject  acc : locatorAccounts) {
            accounts.add((Account) acc); 
          }
          Test.stopTest();
  
          // Vérification que des comptes sont retournés
          System.assert(accounts.size() > 0, 'Aucun compte n\'a été retourné.');


    }



 


}