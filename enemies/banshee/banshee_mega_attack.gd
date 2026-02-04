extends ConditionalAction

@export var damage := 15

var already_used := false

func is_performable() -> bool:
	if not enemy or not target or already_used:
		return false
	
	var is_low := enemy.stats.health <= enemy.stats.max_health * 0.5
	already_used = is_low
	return is_low

func perform_action() -> void:
	if not enemy or not target:
		return
	
	var target_array: Array[Node] = [target]
	
	
	var tween := create_tween()
	var start := enemy.global_position
	var end := target.global_position + Vector2.RIGHT * 64
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(enemy, "global_position", end, 0.2)
	tween.tween_callback(Apply.damage.bind(target_array, damage))
	tween.tween_callback(SFXPlayer.play.bind(sfx))
	tween.tween_interval(0.25)
	tween.tween_property(enemy, "global_position", start, 0.4)
	tween.finished.connect(func(): Events.enemy_action_completed.emit(enemy))
	
func update_intent_text() -> void:
	if not target:
		return
	#var hero: Hero = target
	var modified_dmg := hero.modifier_handler.get_modified_value(damage, Modifier.Type.DMG_TAKEN)
	intent.current_text = intent.base_text % modified_dmg
