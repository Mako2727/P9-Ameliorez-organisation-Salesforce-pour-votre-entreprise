trigger UpdateAccountCA on Order (after update) {

    try {
         // Récupération des Order mis à jour
         System.debug('Timestamp: ' + System.now() + ' - Debut de l update pour accountId->Chiffre_d_affaire__c');

        //Ancienne approche
         set<Id> setAccountIds = new set<Id>();
    
         for(integer i=0; i< trigger.new.size(); i++){
             Order newOrder= trigger.new[i];
            
             Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =:newOrder.AccountId ];
             acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + newOrder.TotalAmount;
             update acc;
         }


      /*  //Nouvelle approche
         List<Order> updatedOrders = new List<Order>(Trigger.new);
        AccountService.updateAccountTrigger(updatedOrders);*/
        System.debug('Timestamp: ' + System.now() + ' - Fin de l update pour accountId->Chiffre_d_affaire__c');



    } catch (Exception e) {
        
    }
 
  
}