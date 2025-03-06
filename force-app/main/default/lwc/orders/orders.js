import { LightningElement, api,wire } from 'lwc';
import getSumOrdersByAccount from '@salesforce/apex/OrdersController.getSumOrdersByAccount';
import { getRecord } from 'lightning/uiRecordApi';

export default class Orders extends LightningElement {

    @api sumOrdersOfCurrentAccount;
    @api isError = false;
    @api recordId;
    FIELDS = ['Name'];

    @wire(getRecord, { recordId: '$recordId', fields: '$FIELDS' })
    wiredRecord({ error, data }) {
       if (error) {
            console.error('Erreur de récupération des données:', error);
        } else if (data) {         
            this.fetchSumOrders(); 
        }
    }

   fetchSumOrders() {
        getSumOrdersByAccount({ accountId: this.recordId })
            .then(result => {
                // Vérifier si le montant total est valide et supérieur à 0.
                this.sumOrdersOfCurrentAccount = result;
                this.isError = (result <= 0 || result == null); 
            })
            .catch(error => {
                this.isError = true;  // En cas d'erreur d'appel Apex
                console.error("Erreur lors du calcul des commandes : ", error);
            });
    }
}