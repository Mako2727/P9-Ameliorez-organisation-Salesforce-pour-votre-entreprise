global class AccountUpdateBatchJob implements Database.Batchable<SObject>, Schedulable {


    global Database.QueryLocator start(Database.BatchableContext BC) {
        // Appel à la méthode selector pour obtenir les trips à venir
        return OrderSelector.getAllOrder();
    }

    global void execute(Database.BatchableContext BC, List<Order> Orders) {
        Set<Id> orderIds = new Set<Id>();

        for (Order ord : orders) {
            orderIds.add(ord.Id);
        }

        AccountService.updateAccountBatch(orderIds);       
}

global void finish(Database.BatchableContext BC) {
    System.debug('Batch Job terminé.');
}    

//replanifie le batch pour la prochaine execution
global void execute(SchedulableContext sc) {
    AccountUpdateBatchJob batch = new AccountUpdateBatchJob();
    Database.executeBatch(batch);
}

}