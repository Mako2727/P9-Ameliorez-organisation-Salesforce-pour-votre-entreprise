@IsTest
public class TestDataFactory {


    @istest
    public static void createTestgetAccount(){

   // Créer 5 comptes
   List<Account> accounts = new List<Account>();
   for (Integer i = 1; i <= 5; i++) {
       accounts.add(new Account(Name = 'Test Account ' + i));
   }
   insert accounts;

   // Récupérer le Pricebook Standard
   Id standardPricebookId = Test.getStandardPricebookId();

   // Créer un produit
   Product2 product = new Product2(Name = 'Test Product', Family = 'General', IsActive = true);
   insert product;

   // Créer un PricebookEntry pour ce produit
   PricebookEntry pricebookEntry = new PricebookEntry(
       Pricebook2Id = standardPricebookId,
       Product2Id = product.Id,
       UnitPrice = 500,
       IsActive = true
   );
   insert pricebookEntry;

   // Créer les commandes en mode "Draft"
   List<Order> orders = new List<Order>();
   Integer orderCount = 1;
   for (Account acc : accounts) {
       for (Integer j = 1; j <= 5; j++) {
           orders.add(new Order(
               Name = 'Order ' + orderCount,
               Status = 'Draft', // Création en mode "Draft"
               AccountId = acc.Id,
               EffectiveDate = Date.today(),
               Pricebook2Id = standardPricebookId
           ));
           orderCount++;
       }
   }
   insert orders;

   // Associer chaque Order à un OrderItem
   List<OrderItem> orderItems = new List<OrderItem>();
   for (Order order : orders) {
       orderItems.add(new OrderItem(
           OrderId = order.Id,
           PricebookEntryId = pricebookEntry.Id,
           Quantity = 2,
           UnitPrice = 500
       ));
   }
   insert orderItems;

   // Maintenant que les Order ont des produits, on peut les activer
   for (Order ord : orders) {
       ord.Status = 'Activated';
   }
   update orders;

    }


    @IsTest
    public static void createTestUpdateAllAccounts() {
         // Création d'un compte
    Account acc1 = new Account(Name = 'Test Account 1');
    insert acc1;

    // Récupération du Pricebook standard
    Id standardPricebookId = Test.getStandardPricebookId();

    // Création d'un produit actif
    Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise', IsActive = true);
    insert pd1;
 
    // Création d'une entrée dans le Pricebook standard
    PricebookEntry pbe = new PricebookEntry(
        Pricebook2Id = standardPricebookId,
        Product2Id = pd1.Id,
        UnitPrice = 1020,
        IsActive = true
    );
    insert pbe;

    // Création d'une commande avec le Pricebook défini
    Order o1 = new Order(
        AccountId = acc1.Id,
        Status = 'Draft', 
        EffectiveDate = Date.today(), 
        Pricebook2Id = standardPricebookId 
    );
    insert o1;

    // Création des OrderItem après avoir défini un Pricebook
    OrderItem oi1 = new OrderItem(
        OrderId = o1.Id, 
        PricebookEntryId = pbe.Id, 
        Quantity = 10, 
        UnitPrice = 150
    );

    OrderItem oi2 = new OrderItem(
        OrderId = o1.Id, 
        PricebookEntryId = pbe.Id, 
        Quantity = 20, 
        UnitPrice = 1000
    );

    insert new List<OrderItem>{oi1, oi2}; 

    
    o1.Status = 'Activated';
    o1.ActivatedDate = Date.today();
    update o1;

    }

    @IsTest
    public static void createTestUpdateAccount() {
      // Création de comptes de test
List<Account> accounts = new List<Account>();
for (Integer i = 1; i <= 5; i++) {
    accounts.add(new Account(
        Name = 'Test Account ' + i,
        Chiffre_d_affaire__c = 0 // Valeur initiale du Chiffre d'affaire
    ));
}
insert accounts;

// Création de produits et PricebookEntry
Id standardPricebookId = Test.getStandardPricebookId();
Product2 product = new Product2(Name = 'Test Product', Family = 'General', IsActive = true);
insert product;

PricebookEntry pricebookEntry = new PricebookEntry(
    Pricebook2Id = standardPricebookId,
    Product2Id = product.Id,
    UnitPrice = 500,
    IsActive = true
);
insert pricebookEntry;

// Création de commandes avec le statut "Draft"
List<Order> orders = new List<Order>();
for (Account acc : accounts) {
    for (Integer j = 1; j <= 5; j++) {
        Order ord = new Order(
            Name = 'Order ' + j,
            Status = 'Draft',  // Mettre en "Draft"
            AccountId = acc.Id,
            EffectiveDate = Date.today(),
            Pricebook2Id = standardPricebookId
        );
        orders.add(ord);
    }
}
insert orders;

// Création des OrderItems avec un produit, mais les commandes sont toujours en "Draft"
List<OrderItem> orderItems = new List<OrderItem>();
for (Order ord : orders) {
    orderItems.add(new OrderItem(
        OrderId = ord.Id,
        PricebookEntryId = pricebookEntry.Id,
        Quantity = 2,
        UnitPrice = 500
    ));
}
insert orderItems;

// Mettre à jour les commandes pour les passer en "Activated"
for (Order ord : orders) {
    ord.Status = 'Activated';  // Mise à jour du statut à "Activated"
}
update orders;

    }


    @IsTest
    public static void createTestgetSumOrdersByAccount() {
 // Créer un compte
Account acc = new Account(Name = 'Test Account');
insert acc;

// Créer un Pricebook standard
Id standardPricebookId = Test.getStandardPricebookId();

// Créer un produit
Product2 product = new Product2(Name = 'Test Product', Family = 'General', IsActive = true);
insert product;

// Créer un PricebookEntry pour ce produit
PricebookEntry pricebookEntry = new PricebookEntry(
    Pricebook2Id = standardPricebookId,
    Product2Id = product.Id,
    UnitPrice = 500,
    IsActive = true
);
insert pricebookEntry;

// Créer une commande avec le statut "Draft"
Order ord = new Order(
    Name = 'Test Order',
    Status = 'Draft',  // Le statut initial doit être "Draft"
    AccountId = acc.Id,
    EffectiveDate = Date.today(),
    Pricebook2Id = standardPricebookId
);
insert ord;

// Créer un OrderItem pour la commande (ajouter au moins un produit)
OrderItem orderItem = new OrderItem(
    OrderId = ord.Id,
    PricebookEntryId = pricebookEntry.Id,
    Quantity = 2,
    UnitPrice = 500
);
insert orderItem;

// Mettre à jour la commande avec le statut "Activated"
ord.Status = 'Activated'; // Changer le statut après avoir ajouté un produit
update ord;

    }


    @IsTest
    public static void createTestgetTotalAmountByAccount() {
 // Création de comptes de test
List<Account> accounts = new List<Account>();
for (Integer i = 1; i <= 5; i++) {
    accounts.add(new Account(
        Name = 'Test Account ' + i,
        Chiffre_d_affaire__c = 0 // Valeur initiale du Chiffre d'affaire
    ));
}
insert accounts;

// Création de produits et PricebookEntry
Id standardPricebookId = Test.getStandardPricebookId();
Product2 product = new Product2(Name = 'Test Product', Family = 'General', IsActive = true);
insert product;

PricebookEntry pricebookEntry = new PricebookEntry(
    Pricebook2Id = standardPricebookId,
    Product2Id = product.Id,
    UnitPrice = 500,
    IsActive = true
);
insert pricebookEntry;

// Création de commandes et d'OrderItems associés aux comptes
List<Order> orders = new List<Order>();
List<OrderItem> orderItems = new List<OrderItem>();
for (Account acc : accounts) {
    for (Integer j = 1; j <= 5; j++) {
        Order ord = new Order(
            Name = 'Order ' + j,
            Status = 'Draft', // Mettre "Draft" au lieu de "Activated"
            AccountId = acc.Id,
            EffectiveDate = Date.today(),
            Pricebook2Id = standardPricebookId
        );
        orders.add(ord);
    }
}
insert orders;

// Création des OrderItems pour chaque commande
for (Order ord : orders) {
    orderItems.add(new OrderItem(
        OrderId = ord.Id,
        PricebookEntryId = pricebookEntry.Id,
        Quantity = 2,
        UnitPrice = 500
    ));
}
insert orderItems;

// Mettre à jour le statut des commandes à "Activated"
for (Order ord : orders) {
    ord.Status = 'Activated'; // Changer le statut à "Activated"
}
update orders;
    }



    @IsTest
    public static void createTestcalculMontant() {
        Integer numberOfOrders = 5; // Définition explicite

        // Créer un compte
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Récupérer l'ID du Pricebook standard
        Id standardPricebookId = Test.getStandardPricebookId();

        // Créer un produit
        Product2 product = new Product2(Name = 'Test Product', Family = 'General', IsActive = true);
        insert product;

        // Créer un PricebookEntry actif pour ce produit
        PricebookEntry pricebookEntry = new PricebookEntry(
            Pricebook2Id = standardPricebookId,
            Product2Id = product.Id,
            UnitPrice = 500,
            IsActive = true
        );
        insert pricebookEntry;

        // Liste des commandes à insérer
        List<Order> orders = new List<Order>();
        for (Integer i = 1; i <= numberOfOrders; i++) {
            orders.add(new Order(
                Name = 'Order ' + i,
                AccountId = acc.Id,
                Status = 'Draft', // 'Activated' nécessite des OrderItems
                EffectiveDate = Date.today(),
                Pricebook2Id = standardPricebookId,
                ShipmentCost__c = 50 * i // Coût d'expédition dynamique
            ));
        }
        insert orders;

        // Associer des produits aux commandes via OrderItem
        List<OrderItem> orderItems = new List<OrderItem>();
        for (Order ord : orders) {
            orderItems.add(new OrderItem(
                OrderId = ord.Id,
                PricebookEntryId = pricebookEntry.Id,
                Quantity = 2,
                UnitPrice = 500
            ));
        }
        insert orderItems;
    }
    


}

