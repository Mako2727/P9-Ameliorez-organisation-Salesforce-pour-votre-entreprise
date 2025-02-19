@IsTest
private class OrderServiceTest {
    @TestSetup
    static void setup() {
        TestDataFactory.createTestcalculMontant();       
    }


    @IsTest
    static void testcalculMontant() {

           // Création des données de test
           List<Order> orders = [SELECT Id, TotalAmount, ShipmentCost__c, NetAmount__c FROM Order];

           Test.startTest();
           OrderService.calculMontant(orders);
           Test.stopTest();
   
           // Vérification des résultats après exécution de la méthode
           for (Order ord : orders) {
               Decimal expectedNetAmount = 
                   ((ord.TotalAmount != null) ? ord.TotalAmount : 0) - 
                   ((ord.ShipmentCost__c != null) ? ord.ShipmentCost__c : 0);
               
               System.assertEquals(expectedNetAmount, ord.NetAmount__c, 'Erreur dans le calcul du montant net pour la commande ' + ord.Id);
           }


    }


}