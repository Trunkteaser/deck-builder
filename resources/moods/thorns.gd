extends Mood

var tree: SceneTree

func initialize_mood(target: Node) -> void:
	tree = target.get_tree()
	Events.player_possibly_damaged.connect(_on_damage_possibly_taken)

func _on_damage_possibly_taken() -> void:
	var target: Array[Node] = [Apply.acting_enemy]
	#var target := tree.get_nodes_in_group("enemies")
	Apply.damage(target, stacks, Modifier.Type.NO_MODIFIER, false)

func get_tooltip() -> String:
	return tooltip % stacks
