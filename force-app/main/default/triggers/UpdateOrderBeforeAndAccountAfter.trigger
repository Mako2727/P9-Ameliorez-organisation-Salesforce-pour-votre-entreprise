trigger UpdateOrderBeforeAndAccountAfter on Order(before update, after update) {
  try {
    if (Trigger.isBefore && Trigger.isUpdate) {
      OrderService.calculMontant(Trigger.new);
    } else if (Trigger.isAfter && Trigger.isUpdate) {
      AccountService.updateAccountCaActivated(Trigger.new);
    }
  } catch (Exception e) {
    System.debug('Erreur UpdateOrderBeforeAndAccountAfter : ' + e.getMessage());
  }
}
