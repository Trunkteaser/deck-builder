extends Mantra

const i_give_love_freely: Mood = preload("uid://d2l8p58n8t58d")

func activate_mantra(mantra_ui: MantraUI) -> void:
	var hero := mantra_ui.get_tree().get_nodes_in_group("hero")
	Apply.mood(hero, i_give_love_freely)
