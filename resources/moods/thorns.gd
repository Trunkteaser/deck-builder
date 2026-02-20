extends Mood

var thorns_particles = preload("uid://bbbdpkcsuhrjw")
var tree: SceneTree

func initialize_mood(target: Node) -> void:
	tree = target.get_tree()
	Events.player_possibly_damaged.connect(_on_damage_possibly_taken)

func _on_damage_possibly_taken() -> void:
	var target: Array[Node] = [Apply.acting_enemy]
	if not target[0]:
		return
	#var target := tree.get_nodes_in_group("enemies")
	thorns_particles.amount = 100*stacks
	VFXPlayer.particles(target[0].position, Vector2(1,0), thorns_particles)
	Apply.damage(target, stacks, Modifier.Type.NO_MODIFIER, false)
	

func get_tooltip() -> String:
	return tooltip % stacks
