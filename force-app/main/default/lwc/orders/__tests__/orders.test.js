import { createElement } from 'lwc';
import Orders from 'c/orders';
import getSumTotalAmount from '@salesforce/apex/OrdersController.getSumTotalAmount';
import { getRecord } from 'lightning/uiRecordApi';

// Mock global des modules
jest.mock('@salesforce/apex/OrdersController.getSumTotalAmount', () => ({
    default: jest.fn()
}));
jest.mock('lightning/uiRecordApi', () => ({
    getRecord: jest.fn()
}));

// Simule les données pour getRecord
const mockGetRecord = {
    fields: { Name: { value: 'Test Account' } }
};

const mockSumOrders = 100;
const mockZeroSumOrders = 0;
const flushPromises = () => new Promise(resolve => setTimeout(resolve, 100));

describe('c-orders', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        jest.clearAllMocks();
    });
    it('charge la somme des commandes avec succès', async () => {
        getRecord.mockResolvedValue(mockGetRecord);
        getSumTotalAmount.mockResolvedValue(mockSumOrders);
        const element = createElement('c-orders', { is: Orders });
        document.body.appendChild(element);
        await flushPromises();
        expect(element.sumOrdersOfCurrentAccount).toBe(mockSumOrders.value);
    });
});

    describe('c-orders', () => {
        afterEach(() => {
            while (document.body.firstChild) {
                document.body.removeChild(document.body.firstChild);
            }
            jest.clearAllMocks();
        });
    it('gère une somme de commande à zéro', async () => {
        getRecord.mockResolvedValue(mockGetRecord);
        getSumTotalAmount.mockResolvedValue(mockZeroSumOrders);
        const element = createElement('c-orders', { is: Orders });
        document.body.appendChild(element);
        await flushPromises();  
        expect(element.sumOrdersOfCurrentAccount).toBe(mockZeroSumOrders.value);
    });
  });
