extends EventData

const STING = preload("uid://cshy6x3llsfd4")
const WICKED_STING = preload("uid://dhrhpypnvk0dk")

func option_1_chosen() -> void:
	hero_stats.deck.add_card(STING)
	Events.event_exited.emit()
	
func option_2_chosen() -> void:
	hero_stats.deck.add_card(WICKED_STING)
	Events.event_exited.emit()
	
func option_3_chosen() -> void:
	Events.event_exited.emit()

func get_option_1_description() -> String:
	return option_1

func get_option_2_description() -> String:
	return option_2

func get_option_3_description() -> String:
	return option_3
