trigger CalculMontant on Order (before update) {
	OrderService.calculMontant(Trigger.new);
}