extends Mantra

const ANGER = preload("uid://bl7yry7rm0qru")

var violence_count := 0
var ui: MantraUI

func initialize_mantra(mantra_ui: MantraUI) -> void:
	ui = mantra_ui
	Events.player_hand_drawn.connect(_on_player_hand_drawn)
	Events.card_played.connect(_on_card_played)

func _on_player_hand_drawn() -> void:
	violence_count = 0

func _on_card_played(card_data: CardData) -> void:
	if card_data.type == card_data.Type.VIOLENCE:
		violence_count += 1
		if violence_count % 3 == 0:
			var hero := ui.get_tree().get_nodes_in_group("hero")
			Apply.mood(hero, ANGER, 1)
			ui.flash()

func deactivate_mantra(_mantra_ui: MantraUI) -> void:
	Events.player_hand_drawn.disconnect(_on_player_hand_drawn)
	Events.card_played.disconnect(_on_card_played)
