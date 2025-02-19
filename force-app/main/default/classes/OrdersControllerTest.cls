@IsTest
private class OrdersControllerTest {

    @TestSetup
    static void setup() {
        TestDataFactory.createTestgetSumOrdersByAccount();
    }


    @IsTest
    static void testgetSumOrdersByAccount() {

          // Récupérer l'ID de la commande
          Order testOrder = [SELECT Id FROM Order WHERE Status = 'Activated' LIMIT 1];
        
          // Test de la méthode getSumTotalAmount
          Test.startTest();
          Decimal totalAmount = OrdersController.getSumOrdersByAccount(testOrder.Id);
          Test.stopTest();
          
          // Vérification que le montant total est correct
          Decimal expectedAmount = 500 * 2; // 2 produits, 500 par produit
          System.assertEquals(expectedAmount, totalAmount, 'Le montant total retourné par la méthode est incorrect.');

    }



}