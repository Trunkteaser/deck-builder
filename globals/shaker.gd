extends Node

func shake(shakee: Node2D, intensity: float = 32, duration: float = 0.2) -> void:
	if not shakee:
		return
	var orig_pos := shakee.position
	var shake_count := 10
	var tween := create_tween()
	for i in shake_count:
		var shake_offset := Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
		var target := orig_pos + intensity * shake_offset
		if i % 2 == 0: # Every other shake...
			target = orig_pos
		tween.tween_property(shakee, "position", target, duration/float(shake_count))
		intensity *= 0.75
	tween.finished.connect(func(): shakee.position = orig_pos)
	
