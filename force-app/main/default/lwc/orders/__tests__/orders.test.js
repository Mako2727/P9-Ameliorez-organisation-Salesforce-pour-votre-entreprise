
import Orders from 'c/orders';
import getSumOrdersByAccount from '@salesforce/apex/OrdersController.getSumOrdersByAccount';
import { getRecord } from 'lightning/uiRecordApi';

// Simule les données pour getRecord
const mockGetRecord = {
    fields: { Name: { value: 'Test Account' } }
};

// Simule les résultats pour getSumOrdersByAccount
const mockSumOrders = 100;
const mockZeroSumOrders = 0;


// Mock des appels Apex
jest.mock('@salesforce/apex/OrdersController.getSumOrdersByAccount', () => ({
    default: jest.fn()
}));

jest.mock('lightning/uiRecordApi', () => ({
    getRecord: jest.fn()
}));

describe('c-orders', () => {
    afterEach(() => {
        // Réinitialiser le DOM après chaque test
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        jest.clearAllMocks();
    });

    it('charge la somme des commandes avec succès', async () => {
        // Arrange : mock des données
        getRecord.mockResolvedValue(mockGetRecord);
        getSumOrdersByAccount.mockResolvedValue(mockSumOrders);

        const element = createElement('c-orders', {
            is: Orders
        });

        // Act : append l'élément au DOM
        document.body.appendChild(element);

        // Attendre la résolution des appels asynchrones
        await Promise.resolve();

        // Assert : vérification du résultat
        expect(element.sumOrdersOfCurrentAccount).toBe(mockSumOrders);
        expect(element.isError).toBe(false);
    });

    it('gère une somme de commande à zéro', async () => {
        // Arrange : mock des données
        getRecord.mockResolvedValue(mockGetRecord);
        getSumOrdersByAccount.mockResolvedValue(mockZeroSumOrders);

        const element = createElement('c-orders', {
            is: Orders
        });

        document.body.appendChild(element);

        await Promise.resolve();

        expect(element.sumOrdersOfCurrentAccount).toBe(mockZeroSumOrders);
        expect(element.isError).toBe(true);
    });

    it('gère une erreur lors de l’appel Apex', async () => {
        // Arrange : simuler une erreur Apex
        getRecord.mockResolvedValue(mockGetRecord);
        getSumOrdersByAccount.mockRejectedValue(new Error('Apex error'));

        const element = createElement('c-orders', {
            is: Orders
        });

        document.body.appendChild(element);

        await Promise.resolve();

        expect(element.sumOrdersOfCurrentAccount).toBe(0);
        expect(element.isError).toBe(true);
    });
});