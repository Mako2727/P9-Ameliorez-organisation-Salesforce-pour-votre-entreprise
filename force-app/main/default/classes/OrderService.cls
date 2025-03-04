public class OrderService {
    public static void calculMontant(List<Order> orders)
    { 
        System.debug('Timestamp: ' + System.now() + ' - Debut de l update pour calculMontant'); 
        if (Order.getSObjectType().getDescribe().isUpdateable()) {
            List<Order> ord=new List<Order>();
            for (Order newOrder : orders) {
                try {               
                    if (newOrder.Status=='Activated')
                    {
                        //newOrder.NetAmount__c = newOrder.totalAmount - newOrder.ShipmentCost__c;
                        ord=orders;
                        ord.NetAmount__c = newOrder.totalAmount - newOrder.ShipmentCost__c;
                    } 
                } catch (Exception e) {
                    newOrder.addError('Erreur lors du calculMontant : ' + e.getMessage());
                }
            }  

            update ord;
        } 
        System.debug('Timestamp: ' + System.now() + ' - Fin  de l update pour calculMontant');  
    }
}