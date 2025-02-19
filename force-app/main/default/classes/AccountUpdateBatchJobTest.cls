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

        List<Account> accounts = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name LIKE 'Test Account%'];
        // Vérifications après l'exécution de la méthode
        List<Account> updatedAccounts = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :accounts];

        // Vérification que le Chiffre d'affaire a bien été mis à jour
        for (Account acc : updatedAccounts) {
            System.assert(acc.Chiffre_d_affaire__c > 0, 'Le chiffre d\'affaire du compte devrait être mis à jour');
        }

    }


}