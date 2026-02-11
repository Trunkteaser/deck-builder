extends Mantra

const FEAR = preload("uid://t28wluftr7m")

func activate_mantra(mantra_ui: MantraUI) -> void:
	var enemies := mantra_ui.get_tree().get_nodes_in_group("enemies")
	Apply.mood(enemies, FEAR, 1)
	mantra_ui.flash()
