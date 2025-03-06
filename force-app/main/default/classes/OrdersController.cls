public without sharing class OrdersController {
    
    // TODO - Corriger l'erreur ici, nous retournons le montant TOTAL de tous les "Orders" 
    // mais nous souhaitons retourner le montant TOTAL des orders  aux status = 'Activated' du compte sur lequel le composant LWC se situe
    @AuraEnabled (cacheable=false)
    public static Decimal getSumOrdersByAccount(Id accountId) {
        Decimal TotalAmount=  OrderSelector.getSumTotalAmount(accountId);    
        return  TotalAmount;
    }

}