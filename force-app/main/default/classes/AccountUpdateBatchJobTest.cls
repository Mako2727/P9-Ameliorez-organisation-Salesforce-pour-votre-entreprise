@IsTest
private class AccountUpdateBatchJobTest {
  @TestSetup
  static void setup() {
    TestDataFactory.createTestUpdateAccount();
  }

  @IsTest
  static void testAccountUpdateBatchJob() {
    Test.startTest();
    AccountUpdateBatchJob batch = new AccountUpdateBatchJob();
    Database.executeBatch(batch);
    Test.stopTest();

    List<Account> accounts = [
      SELECT Id, Chiffre_d_affaire__c
      FROM Account
      WHERE Name LIKE 'Test Account%'
    ];
    // Vérifications après l'exécution de la méthode
    List<Account> updatedAccounts = [
      SELECT Id, Chiffre_d_affaire__c
      FROM Account
      WHERE Id IN :accounts
    ];

    // Récupération du total des montants par compte via OrderSelector
       Map<Id, Decimal> totalAmountByAccount = OrderSelector.getTotalAmountByAccount(accounts);       
    
    // Vérification que le Chiffre d'affaire a bien été mis à jour
    for (Account acc : updatedAccounts) {
      Decimal expectedChiffre_d_affaire= totalAmountByAccount.get(acc.Id);
      System.assertEquals(expectedChiffre_d_affaire,acc.Chiffre_d_affaire__c,'Le montant du chiffre d affaire n est pas correct' ); 
    }
  }
} 
