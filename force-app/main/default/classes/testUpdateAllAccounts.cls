@isTest
private class TestUpdateAllAccounts {

    @TestSetup
    static void setup() {
        TestDataFactory.createTestUpdateAllAccounts();       
    }



    @isTest 
static void Test() {

 Set<Id> orderIds = new Set<Id>();
for (Order ord : [SELECT Id FROM Order WHERE Status = 'Activated']) {
    orderIds.add(ord.Id);}
             
            //AccountService.UpdateAccount(orderIds);
      

            Test.startTest();
    // Vérification du chiffre d'affaires mis à jour
    for (Account acc : [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Id IN :orderIds)]) {
        AggregateResult result = [SELECT SUM(TotalAmount) totalAmount FROM Order WHERE AccountId = :acc.Id AND Id IN :orderIds];
        Decimal expectedTotal = (result.get('totalAmount') != null) ? (Decimal) result.get('totalAmount') : 0;
        Test.stopTest();
        System.assertEquals(expectedTotal, acc.Chiffre_d_affaire__c, 
            'Le chiffre d\'affaires du compte ne correspond pas au total des commandes.');
    }


}
}