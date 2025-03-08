public with sharing class OrderService {
  public static void calculMontant(List<Order> orders) {
    if (Order.getSObjectType().getDescribe().isUpdateable()) {
       try { 
        List<Order> ordersToUpdate = new List<Order>();
        for (Order newOrder : orders) {      
            if (newOrder.Status == 'Activated') {
              newOrder.NetAmount__c =
              newOrder.totalAmount - newOrder.ShipmentCost__c;
              ordersToUpdate.add(newOrder);
            }        
        }
        update ordersToUpdate;
        } catch (Exception e) {
              System.debug('Erreur lors du calculMontant : ' + e.getMessage());
        }
    }
  }
}
