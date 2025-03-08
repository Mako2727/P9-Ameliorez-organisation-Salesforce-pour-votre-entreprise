global class AccountUpdateBatchJob implements Database.Batchable<SObject>, Schedulable {
  global Database.QueryLocator start(Database.BatchableContext BC) {
    return AccountSelector.getAccountsWithActivatedOrder();
  }

  global void execute(Database.BatchableContext BC, List<Account> accounts) {
    AccountService.updateAccountCa(accounts);
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
