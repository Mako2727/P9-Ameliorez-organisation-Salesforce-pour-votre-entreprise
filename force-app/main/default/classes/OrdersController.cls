public without sharing class OrdersController {
    
    // TODO - Corriger l'erreur ici, nous retournons le montant TOTAL de tous les "Orders" 
    // mais nous souhaitons retourner le montant TOTAL des orders  aux status = 'Activated' du compte sur lequel le composant LWC se situe
    @AuraEnabled (cacheable=false)
    public static Decimal getSumOrdersByAccount(Id accountId) {

        /*String timeStart = System.now().format('yyyy-MM-dd HH:mm:ss.SSS');
        System.debug('Timestamp: ' + timeStart + ' - Debut de getSumOrdersByAccount');
        Decimal myValue  ;
        AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order] ;
        myValue=  (Decimal)groupedResults.get('total');
        String timeStop = System.now().format('yyyy-MM-dd HH:mm:ss.SSS');
        System.debug('Timestamp: ' + timeStop + ' - Fin de getSumOrdersByAccount');  
        return myValue;*/

        String timeStart = System.now().format('yyyy-MM-dd HH:mm:ss.SSS');
        System.debug('Timestamp: ' + timeStart + ' - Debut de getSumOrdersByAccount');
        Decimal TotalAmount=  OrderSelector.getSumTotalAmount(accountId);      
        String timeStop = System.now().format('yyyy-MM-dd HH:mm:ss.SSS');
        System.debug('Timestamp: ' + timeStop + ' - Fin de getSumOrdersByAccount');        
        return  TotalAmount;
    }

}