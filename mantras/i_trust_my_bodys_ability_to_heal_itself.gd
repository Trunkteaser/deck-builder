extends Mantra

func activate_mantra(mantra_ui: MantraUI) -> void:
	var hero: Hero = mantra_ui.get_tree().get_first_node_in_group("hero")
	if hero:
		#hero.stats.heal(6)
		Apply.heal([hero], 6) # Plays healing sound.
		mantra_ui.flash()
