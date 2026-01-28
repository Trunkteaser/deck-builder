extends Mantra

var turn_count: int = 0

func activate_mantra(mantra_ui: MantraUI) -> void:
	turn_count += 1
	if not turn_count % 3 == 0:
		return
	var hero := mantra_ui.get_tree().get_nodes_in_group("hero")
	Apply.mana(hero, 1)
	mantra_ui.flash()
