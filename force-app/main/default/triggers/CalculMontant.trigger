trigger CalculMontant on Order (before update) {
	try {
			OrderService.calculMontant(Trigger.new); 
		} catch (Exception e) {
			System.debug('Erreur CalculMontant : '+ e.getMessage());
		}
}