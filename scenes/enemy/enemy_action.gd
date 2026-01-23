extends Node
class_name EnemyAction

@export var intent: Intent
@export var sfx: AudioStream
var enemy: Enemy
var target: Node2D

func perform_action() -> void:
	pass

func attack_tween(damage):
	var damage_effect := DamageEffect.new()
	var target_array: Array[Node] = [target]
	if sfx: damage_effect.sfx = sfx
	
	var tween := create_tween()
	var start := enemy.global_position
	var end := enemy.global_position + Vector2.LEFT * 64
	#tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(enemy, "global_position", end, 0.1)
	tween.tween_callback(damage_effect.apply.bind(target_array, damage))
	tween.tween_interval(0.05)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(enemy, "global_position", start, 0.1)
	tween.finished.connect(func(): Events.enemy_action_completed.emit(enemy))

func wait(duration: float) -> Signal:
	return get_tree().create_timer(duration).timeout
