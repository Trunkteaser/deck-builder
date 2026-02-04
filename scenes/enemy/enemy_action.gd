extends Node
class_name EnemyAction

@export var intent: Intent
@export var sfx: AudioStream
var enemy: Enemy
var target: Node2D
var hero: Hero
var targets: Array[Node]

func perform_action() -> void:
	pass

func attack_tween(damage: int) -> Signal:
	var tween := create_tween()
	var start := enemy.global_position
	var end := enemy.global_position + Vector2.LEFT * 64
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(enemy, "global_position", end, 0.1)
	tween.tween_callback(Apply.damage.bind(targets, damage))
	if sfx:
		tween.tween_callback(SFXPlayer.play.bind(sfx))
	tween.tween_interval(0.05)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(enemy, "global_position", start, 0.1)
	return tween.finished

func wait(duration: float) -> Signal:
	return get_tree().create_timer(duration).timeout

func update_intent_text() -> void:
	intent.current_text = intent.base_text
