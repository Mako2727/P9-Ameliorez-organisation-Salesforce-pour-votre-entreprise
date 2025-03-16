@IsTest
private class AccountServiceTest {
  @TestSetup
  static void setup() {
    TestDataFactory.createTestUpdateAccount();
  }

  @IsTest
  static void testUpdateAccountCaActivated() {
    // Récupérer les données de test déjà créées par une autre classe
    List<Account> accounts = [
      SELECT Id, Chiffre_d_affaire__c
      FROM Account
      WHERE Name LIKE 'Test Account%'
    ];
    List<Order> orders = [
      SELECT Id, AccountId, Status
      FROM Order
      WHERE AccountId IN :accounts
    ];

    // Test de la méthode updateAccount
    Test.startTest();
    AccountService.updateAccountCaActivated(orders);
    Test.stopTest();

    // Vérifications après l'exécution de la méthode
    List<Account> updatedAccounts = [
      SELECT Id, Chiffre_d_affaire__c
      FROM Account
      WHERE Id IN :accounts
    ];

    // Vérification que le Chiffre d'affaire a bien été mis à jour
    for (Account acc : updatedAccounts) {
      System.assert(
        acc.Chiffre_d_affaire__c > 0,
        'Le chiffre d\'affaire du compte devrait être mis à jour'
      );
    }
  }

  @IsTest
  static void testupdateAccountCa() {
    // Récupérer les données de test déjà créées par une autre classe
    List<Account> accounts = [
      SELECT Id, Chiffre_d_affaire__c
      FROM Account
      WHERE Name = 'Test Account '
    ];

    // Test de la méthode updateAccount
    Test.startTest();
    AccountService.updateAccountCa(accounts);
    Test.stopTest();

    

    // Récupération du total des montants par compte via OrderSelector
    Map<Id, Decimal> totalAmountByAccount = OrderSelector.getTotalAmountByAccount(accounts);      
    
    // Vérification que le Chiffre d'affaire a bien été mis à jour
    for (Account acc : accounts) {
      Decimal expectedChiffre_d_affaire= totalAmountByAccount.get(acc.Id);
      System.assertEquals(expectedChiffre_d_affaire,acc.Chiffre_d_affaire__c,'Le montant du chiffre d affaire n est pas correct' );
    }
  }
}
