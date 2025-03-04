trigger UpdateAccountCA on Order (after update) {

    try {
         // Récupération des Order mis à jour
         System.debug('Timestamp: ' + System.now() + ' - Debut de l update pour accountId->Chiffre_d_affaire__c');      


        //Nouvelle approche
         List<Order> updatedOrders = new List<Order>(Trigger.new);
        AccountService.updateAccountTrigger(updatedOrders);
        System.debug('Timestamp: ' + System.now() + ' - Fin de l update pour accountId->Chiffre_d_affaire__c');



    } catch (Exception e) {
        
    }
 
  
}