import { LightningElement, api,wire } from 'lwc';
import getSumOrdersByAccount from '@salesforce/apex/OrdersController.getSumOrdersByAccount';
import { refreshApex } from '@salesforce/apex';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';
import { getRecord } from 'lightning/uiRecordApi';

export default class Orders extends LightningElement {

    sumOrdersOfCurrentAccount;
    isError = false;
    @api recordId;
   

    FIELDS = ['Name'];

    @wire(getRecord, { recordId: '$recordId', fields: '$FIELDS' })
    wiredRecord({ error, data }) {
        if (error) {
            console.error('Erreur de récupération des données:', error);
        } else if (data) {         
            this.fetchSumOrders(); // Appel pour mettre à jour conditionMet
        }
    }

    fetchSumOrders() {
        getSumOrdersByAccount({ orderId: this.recordId })
            .then(result => {
                // Vérifier si le montant total est valide et supérieur à 0.
                this.sumOrdersOfCurrentAccount = result;
                this.isError = (result <= 0 || result == null);  // Condition d'erreur
            })
            .catch(error => {
                this.isError = true;  // En cas d'erreur d'appel Apex
                this.sumOrdersOfCurrentAccount = 0;  // Montant à 0 en cas d'erreur
                console.error("Erreur lors du calcul des commandes : ", error);
            });
    }

}