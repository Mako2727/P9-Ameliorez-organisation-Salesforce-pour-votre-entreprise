public class OrderService {
    public static void calculMontant(List<Order> orders)
    { 
        System.debug('Timestamp: ' + System.now() + ' - Debut de l update pour calculMontant'); 
         // Liste pour les ordres modifiés
         List<Order> ordersToUpdate = new List<Order>();
        if (Order.getSObjectType().getDescribe().isUpdateable()) {
            for (Order newOrder : orders) {
                try {               
                    if (newOrder.Status=='Activated')
                    {
                        newOrder.NetAmount__c = newOrder.totalAmount - newOrder.ShipmentCost__c;
                        ordersToUpdate.add(newOrder);
                    } 
                } catch (Exception e) {
                    newOrder.addError('Erreur lors du calculMontant : ' + e.getMessage());
                }
            }
            
            if (!ordersToUpdate.isEmpty()) {
                try {
                    update ordersToUpdate;
                } catch (DmlException e) {
                    System.debug('Erreur lors de la mise à jour des ordres : ' + e.getMessage());
                   
                }
            }        
        } 
        System.debug('Timestamp: ' + System.now() + ' - Fin  de l update pour calculMontant');  
    }
}