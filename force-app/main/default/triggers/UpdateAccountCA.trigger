trigger UpdateAccountCA on Order (after update) {

    try {
         // Récupération des Order mis à jour
         List<Order> updatedOrders = new List<Order>(Trigger.new);
            AccountService.updateAccountTrigger(updatedOrders);

    } catch (Exception e) {
        
    }
 
  
}