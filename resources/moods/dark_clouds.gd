extends Mood

const STATIC_SFX = preload("uid://cba4h3ma7w31v")

func initialize_mood(_target: Node) -> void:
	# Connect to Events if EVENT_BASED.
	pass

func trigger_mood(target: Node) -> void:
	var enemies:= target.get_tree().get_nodes_in_group("enemies")
	var hero := target.get_tree().get_first_node_in_group("hero")
	if not hero.mood_handler._get_mood("Static"):
		Apply.damage(enemies, 5, Modifier.Type.NO_MODIFIER)
		SFXPlayer.play(STATIC_SFX)
	elif hero.mood_handler._get_mood("Static").stacks > 3:
		Apply.damage(enemies, 15, Modifier.Type.NO_MODIFIER)
		VFXPlayer.lightning_bolt(enemies[0].global_position)
	else:
		Apply.damage(enemies, 5, Modifier.Type.NO_MODIFIER)
		SFXPlayer.play(STATIC_SFX)
	mood_triggered.emit(self)
