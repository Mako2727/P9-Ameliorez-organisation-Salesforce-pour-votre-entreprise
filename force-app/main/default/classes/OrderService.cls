public class OrderService {


    public static void calculMontant(List<Order> orders)
    { 

        for (Order newOrder : orders) {
            try {
                Decimal totalAmount = (newOrder.TotalAmount != null) ? newOrder.TotalAmount : 0;
                Decimal shipmentCost = (newOrder.ShipmentCost__c != null) ? newOrder.ShipmentCost__c : 0;
                System.debug('totalAmount...' + totalAmount);
                System.debug('shipmentCost...' + shipmentCost);
                newOrder.NetAmount__c = totalAmount - shipmentCost;
    
            } catch (Exception e) {
                newOrder.addError('Erreur lors du calcul du montant net : ' + e.getMessage());
            }
        }

        
    }
}