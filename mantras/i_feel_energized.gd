extends Mantra

const SFX = preload("uid://dudqlp1mly8lt")

func activate_mantra(mantra_ui: MantraUI) -> void:
	Events.post_mana_reset.connect(_add_mana.bind(mantra_ui), CONNECT_ONE_SHOT)
	# Just so reset_mana doesn't remove +1.

func _add_mana(mantra_ui: MantraUI) -> void:
	mantra_ui.flash()
	var hero: Hero = mantra_ui.get_tree().get_first_node_in_group("hero")
	hero.stats.mana += 1
	SFXPlayer.play(SFX)
