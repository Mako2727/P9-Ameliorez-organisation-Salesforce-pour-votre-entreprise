@IsTest
private class OrdersControllerTest {
  @TestSetup
  static void setup() {
    TestDataFactory.createTestgetSumOrdersByAccount();
  }

  @IsTest
  static void testgetSumOrdersByAccount() {
    Account testAccount = [
      SELECT Id
      FROM Account
      WHERE Name = 'Test Account'
      LIMIT 1
    ];

    // Test de la méthode getSumTotalAmount
    Test.startTest();
    Decimal totalAmount = OrdersController.getSumOrdersByAccount(
      testAccount.Id
    );
    Test.stopTest();

    // Vérification que le montant total est correct
    Decimal expectedAmount = 500 * 2; // 2 produits, 500 par produit
    System.assertEquals(
      expectedAmount,
      totalAmount,
      'Le montant total retourné par la méthode est incorrect.'
    );
  }
}
