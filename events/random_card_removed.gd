extends EventData

var random_card: CardData

func option_1_chosen() -> void:
	hero_stats.deck.remove_card(random_card)
	Events.event_exited.emit()
	

func get_option_1_description() -> String:
	random_card = hero_stats.deck.cards.pick_random()
	return option_1 % random_card.name
