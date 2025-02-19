trigger UpdateAccountCA on Order (after update) {

    try {
            AccountService.updateAccount(Trigger.newMap.keySet());

    } catch (Exception e) {
        
    }
 
  
}