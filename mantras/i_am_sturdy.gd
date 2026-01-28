extends Mantra

func activate_mantra(mantra_ui: MantraUI) -> void:
	var hero := mantra_ui.get_tree().get_nodes_in_group("hero")
	Apply.block(hero, 3)
	mantra_ui.flash()
