public without sharing class OrdersController {
    
    // TODO - Corriger l'erreur ici, nous retournons le montant TOTAL de tous les "Orders" 
    // mais nous souhaitons retourner le montant TOTAL des orders  aux status = 'Activated' du compte sur lequel le composant LWC se situe
    @AuraEnabled (cacheable=false)
    public static Decimal getSumOrdersByAccount(Id orderId) {

        System.debug('Timestamp: ' + System.now() + ' - Debut de getSumOrdersByAccount');
        Decimal myValue  ;
        AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
        myValue=  (Decimal)groupedResults.get('total');
        System.debug('Timestamp: ' + System.now() + ' - Debut de getSumOrdersByAccount');  
        return myValue;
        /*Decimal TotalAmount=  OrderSelector.getSumTotalAmount(orderId);        
        return  TotalAmount;*/
    }

}