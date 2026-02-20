extends Mood

const STATIC_SFX = preload("uid://cba4h3ma7w31v")
@export var damage := 5

func trigger_mood(target: Node) -> void:
	var random_enemy: Node = target.get_tree().get_nodes_in_group("enemies").pick_random()
	Apply.damage([random_enemy], damage, Modifier.Type.NO_MODIFIER)
	SFXPlayer.play(STATIC_SFX)
	stacks -= 1
	mood_triggered.emit(self)

func get_tooltip() -> String:
	return tooltip % damage
