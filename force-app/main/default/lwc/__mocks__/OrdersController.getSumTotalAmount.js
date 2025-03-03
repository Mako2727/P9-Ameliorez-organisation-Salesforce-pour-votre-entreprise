jest.mock('@salesforce/apex/OrdersController.getSumTotalAmount', () => ({
    getSumTotalAmount: jest.fn()
        .mockResolvedValueOnce(100)   // Pour un premier appel, la valeur est 100
        .mockRejectedValueOnce(new Error('Apex error')) // Pour le suivant, une erreur est levée
}));