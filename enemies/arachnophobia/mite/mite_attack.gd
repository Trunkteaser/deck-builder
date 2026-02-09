extends ChanceBasedAction

const MITE_CARD = preload("uid://eynjiijuxrvr")

func perform_action() -> void:
	Apply.death(enemy)
	hero.stats.discard_pile.add_card(MITE_CARD)
