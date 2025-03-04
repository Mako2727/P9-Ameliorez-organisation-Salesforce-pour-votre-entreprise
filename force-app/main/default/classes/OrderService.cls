public class OrderService {
    public static void calculMontant(List<Order> orders)
    { 
        System.debug('Timestamp: ' + System.now() + ' - Debut de l update pour calculMontant'); 
        if (Order.getSObjectType().getDescribe().isUpdateable()) {
            for (Order newOrder : orders) {
                try {               
                    if (newOrder.Status=='Activated')
                    {
                        newOrder.NetAmount__c = newOrder.totalAmount - newOrder.ShipmentCost__c;
                    } 
                } catch (Exception e) {
                    newOrder.addError('Erreur lors du calculMontant : ' + e.getMessage());
                }
            }  
        } 
        System.debug('Timestamp: ' + System.now() + ' - Fin de l update pour accountId->Chiffre_d_affaire__c');  
    }
}