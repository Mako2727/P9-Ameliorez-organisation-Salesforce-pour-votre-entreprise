public without sharing class OrdersController {
    
    // TODO - Corriger l'erreur ici, nous retournons le montant TOTAL de tous les "Orders" 
    // mais nous souhaitons retourner le montant TOTAL des orders  aux status = 'Activated' du compte sur lequel le composant LWC se situe
    @AuraEnabled
    public static Decimal getSumOrdersByAccount(Id orderId) {
        Decimal TotalAmount=  OrderSelector.getSumTotalAmount(orderId);
        
        return  TotalAmount;
    }

}