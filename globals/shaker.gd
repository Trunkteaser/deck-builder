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
	await tween.finished
	if shakee:
		shakee.position = orig_pos
	#if shakee:
		#tween.finished.connect(func(): shakee.position = orig_pos)
	# All variations of the above was causing...
	# Lambda capture at index 0 was freed. Passed "null" instead. ERROR
	# ...when enemy killed by multihit move.
	# is_instance_valid did not help.
	
	
