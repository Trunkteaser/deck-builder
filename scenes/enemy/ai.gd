@icon("res://assets/sprites/brain.png")
extends Node
class_name EnemyAI

@export var enemy: Enemy : set = _set_enemy
@export var target: Node2D: set = _set_target

@onready var total_weight := 0.0

var targets: Array[Node]

func _ready() -> void:
	target = get_tree().get_first_node_in_group("hero")
	setup_chances()

func get_action() -> EnemyAction:
	var action := get_first_conditional_action() # Make this an array?
	if action:
		return action
	return get_chance_based_action()

func get_first_conditional_action() -> ConditionalAction:
	for action: EnemyAction in get_children():
		if action is ConditionalAction:
			if action.is_performable():
				return action
	return null

func get_chance_based_action() -> ChanceBasedAction:
	var roll := randf_range(0.0, total_weight)
	for action: EnemyAction in get_children():
		if action is ChanceBasedAction:
			if action.accumulated_weight > roll:
				return action
	return null

func setup_chances() -> void:
	for action: EnemyAction in get_children():
		if action is ChanceBasedAction:
			total_weight += action.chance_weight
			action.accumulated_weight = total_weight

func attack_tween() -> void: # Might be impractical since dmg callback.
	#var tween := create_tween()
	#var start := enemy.global_position
	#var end := target.global_position + Vector2.RIGHT * 64
	#tween.set_trans(Tween.TRANS_QUINT)
	#tween.tween_property(enemy, "global_position", end, 0.2)
	#tween.tween_callback(damage_effect.apply.bind(target_array))
	#tween.tween_interval(0.25)
	#tween.tween_property(enemy, "global_position", start, 0.4)
	pass

func _set_enemy(new_enemy: Enemy) -> void:
	enemy = new_enemy
	for action: EnemyAction in get_children():
		action.enemy = enemy

func _set_target(new_target: Node2D) -> void:
	target = new_target
	for action: EnemyAction in get_children():
		action.target = target
		action.hero = target
		action.targets = [target]
