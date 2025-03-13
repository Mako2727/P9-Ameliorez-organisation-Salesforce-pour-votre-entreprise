@IsTest
private class OrderSelectorTest {
  @TestSetup
  static void setup() {
    TestDataFactory.createTestgetSumOrdersByAccount();
    TestDataFactory.createTestgetTotalAmountByAccount();
  }

  @IsTest
  static void testgetSumTotalAmount() {
    Account testAccount = [
      SELECT Id
      FROM Account
      WHERE Name = 'Test Account'
      LIMIT 1
    ];

    // Test de la méthode getSumTotalAmount
    Test.startTest();
    Decimal totalAmount = OrderSelector.getSumTotalAmount(testAccount.Id);
    Test.stopTest();

    // Vérification que le montant total est correct
    Decimal expectedAmount = 500 * 2; // 2 produits, 500 par produit
    System.assertEquals(
      expectedAmount,
      totalAmount,
      'Le montant total retourné par la méthode est incorrect.'
    );
  }

  @IsTest
  static void testgetTotalAmountByAccount() {
    // Récupérer les IDs des commandes insérées
    List<Order> Orders = [
      SELECT AccountId
      FROM Order
      WHERE Status = 'Activated'
    ];
    Set<Id> accountIds = new Set<Id>();
    for (Order o : Orders) {
      if (o.AccountId != null) {
        // Vérifier que AccountId n'est pas null
        accountIds.add(o.AccountId);
      }
    }

    List<Account> Accounts = [SELECT Id FROM Account WHERE id IN :accountIds];

    // Test de la méthode qui calcule le total par compte
    Test.startTest();
    Map<Id, Decimal> result = OrderSelector.getTotalAmountByAccount(Accounts);
    Test.stopTest();

    // Vérification des résultats
    System.assertNotEquals(
      result,
      null,
      'La carte des montants totaux ne doit pas être nulle'
    );
    System.assertEquals(
      result.size(),
      6,
      'Il devrait y avoir un total par compte'
    );

    // Vérification du montant pour chaque compte
    for (Id accountId : result.keySet()) {
      Decimal totalAmount = result.get(accountId);
      System.assertEquals(totalAmount,acc.Chiffre_d_affaire__c,'Le montant du chiffre d affaire n est pas correct' );
    }
  }
}
