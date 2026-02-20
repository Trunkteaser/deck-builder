extends Mantra

const THORNS = preload("uid://ppnjhh12qxjo")

func activate_mantra(mantra_ui: MantraUI) -> void:
	var hero := mantra_ui.get_tree().get_nodes_in_group("hero")
	Apply.mood(hero, THORNS, 5)
	mantra_ui.flash()

func get_tooltip() -> String:
	return tooltip
	# Only useful if "magic number".
