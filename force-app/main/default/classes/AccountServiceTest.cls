@IsTest
private class AccountServiceTest {
    @TestSetup
    static void setup() {
      TestDataFactory.createTestUpdateAccount();
    }


    @IsTest
    static void testUpdateAccount() {

        // Récupérer les données de test déjà créées par une autre classe
        List<Account> accounts = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name LIKE 'Test Account%'];
        List<Order> orders = [SELECT Id, AccountId FROM Order WHERE AccountId IN :accounts];

        // Créer un Set<Id> avec les OrderIds
        Set<Id> orderIds = new Set<Id>();
        for (Order ord : orders) {
            orderIds.add(ord.Id);
        }

        // Test de la méthode updateAccount
        Test.startTest();
        AccountService.updateAccount(orderIds);
        Test.stopTest();

        // Vérifications après l'exécution de la méthode
        List<Account> updatedAccounts = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :accounts];

        // Vérification que le Chiffre d'affaire a bien été mis à jour
        for (Account acc : updatedAccounts) {
            System.assert(acc.Chiffre_d_affaire__c > 0, 'Le chiffre d\'affaire du compte devrait être mis à jour');
        }
    }


    @IsTest
    static void testUpdateAccountBatch() {
  // Récupérer les données de test déjà créées par une autre classe
  List<Account> accounts = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name LIKE 'Test Account%'];
  List<Order> orders = [SELECT Id, AccountId FROM Order WHERE AccountId IN :accounts];

  // Créer un Set<Id> avec les OrderIds
  Set<Id> orderIds = new Set<Id>();
  for (Order ord : orders) {
      orderIds.add(ord.Id);
  }

  // Test de la méthode updateAccount
  Test.startTest();
  AccountService.updateAccountBatch(orderIds);
  Test.stopTest();

  // Vérifications après l'exécution de la méthode
  List<Account> updatedAccounts = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :accounts];

  // Vérification que le Chiffre d'affaire a bien été mis à jour
  for (Account acc : updatedAccounts) {
      System.assert(acc.Chiffre_d_affaire__c > 0, 'Le chiffre d\'affaire du compte devrait être mis à jour');
  }

    }



}