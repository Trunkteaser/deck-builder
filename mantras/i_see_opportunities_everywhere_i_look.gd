extends Mantra

func initialize_mantra(mantra_ui: MantraUI) -> void:
	Events.enemy_died.connect(_on_enemy_died.bind(mantra_ui))

func _on_enemy_died(_enemy: Enemy, mantra_ui: MantraUI) -> void:
	var hero := mantra_ui.get_tree().get_nodes_in_group("hero")
	Apply.mana(hero, 1)
	Apply.draw(1)
	mantra_ui.flash()

func deactivate_mantra(_mantra_ui: MantraUI) -> void:
	Events.enemy_died.disconnect(_on_enemy_died)
