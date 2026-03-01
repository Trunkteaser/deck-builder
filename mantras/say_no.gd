extends Mantra

const sfx = preload("uid://hnpv6hjd7j5e")

var ui: MantraUI
var run_stats: RunStats

func initialize_mantra(mantra_ui: MantraUI) -> void:
	ui = mantra_ui
	run_stats = mantra_ui.get_tree().get_first_node_in_group("run").stats
	Events.card_reward_selected.connect(_on_card_reward_selected)

func _on_card_reward_selected(card_data: CardData) -> void:
	if card_data == null:
		run_stats.inspiration += 30
		SFXPlayer.play(sfx)
		ui.flash()

func deactivate_mantra(_mantra_ui: MantraUI) -> void:
	Events.card_reward_selected.disconnect(_on_card_reward_selected)
