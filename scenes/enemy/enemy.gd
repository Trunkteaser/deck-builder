extends Area2D
class_name Enemy

# TODO Script enemy so it will adapt collision shape, stats_ui and arrow to different sizes.

const ARROW_OFFSET := 5
const WHITE_SPRITE_MATERIAL = preload("uid://ceemqhtjalmbl")

@export var stats: EnemyStats : set = set_enemy_stats

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var arrow: Sprite2D = $Arrow
@onready var stats_ui: StatsUI = $StatsUI
@onready var intent_ui: IntentUI = $IntentUI

var enemy_ai: EnemyAI
var current_action: EnemyAction : set = set_current_action

func set_enemy_stats(new_enemy_stats: EnemyStats) -> void:
	stats = new_enemy_stats.create_instance()
	stats.position = position
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
		stats.stats_changed.connect(update_action)
	update_enemy()

func set_current_action(new_action: EnemyAction) -> void:
	current_action = new_action
	if current_action:
		intent_ui.update_intent(current_action.intent)

func setup_ai() -> void:
	if enemy_ai:
		enemy_ai.queue_free()
	var new_enemy_ai: EnemyAI = stats.ai.instantiate()
	add_child(new_enemy_ai)
	enemy_ai = new_enemy_ai
	enemy_ai.enemy = self

func update_stats() -> void:
	stats_ui.update_stats(stats)

func update_action() -> void:
	if not enemy_ai:
		return
	if not current_action:
		current_action = enemy_ai.get_action()
		return
	# Connected to stats_changed signal.
	var new_conditional_action := enemy_ai.get_first_conditional_action()
	if new_conditional_action and current_action != new_conditional_action:
		current_action = new_conditional_action

func update_enemy() -> void:
	if not stats is EnemyStats:
		print("Uh oh should I change it to just UnitStats?")
		return
	if not is_inside_tree():
		await ready
	sprite_2d.texture = stats.art
	arrow.position = Vector2.RIGHT * (sprite_2d.get_rect().size.x/2 + ARROW_OFFSET)
	setup_ai()
	update_stats()

func take_turn() -> void:
	stats.block = 0
	if not current_action:
		return
	current_action.perform_action()

func take_damage(damage: int) -> void:
	if stats.health <= 0:
		return
	
	sprite_2d.material = WHITE_SPRITE_MATERIAL
	
	var tween := create_tween()
	tween.tween_callback(Shaker.shake.bind(self, 32, 0.15))
	tween.tween_callback(stats.take_damage.bind(damage))
	tween.tween_interval(0.17)
	
	tween.finished.connect(
		func():
			sprite_2d.material = null
			if stats.health <= 0:
				queue_free())

func _on_area_entered(_area: Area2D) -> void:
	arrow.show()

func _on_area_exited(_area: Area2D) -> void:
	arrow.hide()
