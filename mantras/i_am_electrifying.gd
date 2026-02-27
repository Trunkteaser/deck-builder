extends Mantra

const STATIC = preload("uid://cyjiq1cs2ewea")
var ui: MantraUI

func initialize_mantra(mantra_ui: MantraUI) -> void:
	ui = mantra_ui
	Events.card_played.connect(_gain_static)

func _gain_static(card_data: CardData) -> void:
	if card_data.cost >= 2:
		var hero := ui.get_tree().get_nodes_in_group("hero")
		Apply.mood(hero, STATIC, 1)
		ui.flash()

func deactivate_mantra(_mantra_ui: MantraUI) -> void:
	Events.card_played.disconnect(_gain_static)
