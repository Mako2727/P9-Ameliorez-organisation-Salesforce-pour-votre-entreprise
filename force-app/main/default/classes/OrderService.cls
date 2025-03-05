public class OrderService {
    public static void calculMontant(List<Order> orders)
    { 
       
        if (Order.getSObjectType().getDescribe().isUpdateable()) {
            for (Order newOrder : orders) {
                try {
                    if (newOrder.Status == 'Activated') {
                        newOrder.NetAmount__c = newOrder.totalAmount - newOrder.ShipmentCost__c;                        
                    }
                } catch (Exception e) {
                    newOrder.addError('Erreur lors du calculMontant : ' + e.getMessage());
                }
            }
        
    }
}
}