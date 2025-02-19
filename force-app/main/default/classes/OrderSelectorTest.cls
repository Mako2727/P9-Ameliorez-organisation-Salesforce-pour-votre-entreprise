@IsTest
private class OrderSelectorTest {

    @TestSetup
    static void setup() {
        TestDataFactory.createTestgetSumOrdersByAccount();
        TestDataFactory.createTestgetTotalAmountByAccount();
    }


    @IsTest
    static void testgetSumTotalAmount() {

          // Récupérer l'ID de la commande
          Order testOrder = [SELECT Id FROM Order WHERE Status = 'Activated' LIMIT 1];
        
          // Test de la méthode getSumTotalAmount
          Test.startTest();
          Decimal totalAmount = OrderSelector.getSumTotalAmount(testOrder.Id);
          Test.stopTest();
          
          // Vérification que le montant total est correct
          Decimal expectedAmount = 500 * 2; // 2 produits, 500 par produit
          System.assertEquals(expectedAmount, totalAmount, 'Le montant total retourné par la méthode est incorrect.');

    }



    @IsTest
    static void testgetTotalAmountByAccount() {
// Récupérer les IDs des commandes insérées
List<Order> ordersActivated = [SELECT Id, AccountId FROM Order WHERE Status = 'Activated'];
Set<Id> orderIds = new Set<Id>();
for (Order ord : ordersActivated) {
    orderIds.add(ord.Id);
}

// Test de la méthode qui calcule le total par compte
Test.startTest();
Map<Id, Decimal> result = OrderSelector.getTotalAmountByAccount(orderIds);
Test.stopTest();

// Vérification des résultats
System.assertNotEquals(result, null, 'La carte des montants totaux ne doit pas être nulle');
System.assertEquals(result.size(), 6, 'Il devrait y avoir un total par compte');

// Vérification du montant pour chaque compte
for (Id accountId : result.keySet()) {
    Decimal totalAmount = result.get(accountId);
    System.assert(totalAmount > 0, 'Le montant total pour le compte ' + accountId + ' doit être supérieur à 0');
}

    }


    @IsTest
    static void testgetAllOrder() {
   
    Integer OrdersCount = 0;
      
    Test.startTest();
     Database.QueryLocator result= OrderSelector.getAllOrder();
     List<Order> Orders = new List<Order>();
     // Utiliser un QueryLocatorIterator pour récupérer les résultats dans la liste
     Database.QueryLocatorIterator iterator = result.iterator();
     while (iterator.hasNext()) {
        Order Order = (Order)iterator.next();
        Orders.add(Order);
        OrdersCount++;
     }  
    Test.stopTest();
  // Vérification que la liste retournée contient bien des résultats
  System.assert(Orders.size() > 0, 'La liste result doit contenir au moins un trip.');
    }
 



}