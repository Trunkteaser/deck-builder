extends ChanceBasedAction

@export var damage := 7

func perform_action() -> void:
	if not enemy or not target:
		return
	

	var target_array: Array[Node] = [target]

	#
	#var tween := create_tween()
	#var start := enemy.global_position
	#var end := target.global_position + Vector2.RIGHT * 64
	#tween.set_trans(Tween.TRANS_QUINT)
	#tween.tween_property(enemy, "global_position", end, 0.2)
	#tween.tween_callback(damage_effect.apply.bind(target_array, damage))
	#tween.tween_interval(0.25)
	#tween.tween_property(enemy, "global_position", start, 0.4)
	#tween.finished.connect(func(): Events.enemy_action_completed.emit(enemy))
	
	var tween := create_tween()
	var start := enemy.global_position
	var end := enemy.global_position + Vector2.LEFT * 64
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(enemy, "global_position", end, 0.05)
	tween.tween_callback(Apply.damage.bind(target_array, damage))
	tween.tween_callback(SFXPlayer.play.bind(sfx))
	tween.tween_interval(0.05)
	tween.tween_property(enemy, "global_position", start, 0.1)
	tween.finished.connect(func(): Events.enemy_action_completed.emit(enemy))
	
