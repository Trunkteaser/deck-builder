extends Node2D
class_name EnemyHandler

var acting_enemies: Array[Enemy] = []

func _ready() -> void:
	Events.enemy_action_completed.connect(_on_enemy_action_completed)
	Events.enemy_died.connect(_on_enemy_died)

func setup_enemies(battle_stats: BattleStats) -> void:
	if not battle_stats:
		return
	for enemy: Enemy in get_children():
		enemy.queue_free()
	var all_new_enemies := battle_stats.enemies.instantiate()
	for new_enemy: Node2D in all_new_enemies.get_children():
		var new_enemy_child: Enemy = new_enemy.duplicate()
		add_child(new_enemy_child)
		new_enemy_child.mood_handler.moods_triggered.connect(_on_enemy_moods_triggered.bind(new_enemy_child))
	all_new_enemies.queue_free() # The contents have been duplicated.

func reset_enemy_actions() -> void:
	for enemy: Enemy in get_children():
		enemy.current_action = null
		enemy.update_action()

func start_turn() -> void:
	if get_child_count() == 0:
		return
	acting_enemies.clear()
	for enemy: Enemy in get_children():
		acting_enemies.append(enemy)
	_start_next_enemy_turn()

func _start_next_enemy_turn() -> void:
	if acting_enemies.is_empty():
		Events.enemy_turn_ended.emit()
		return
	acting_enemies[0].mood_handler.trigger_moods_by_type(Mood.TriggerType.START_OF_TURN)

func _on_enemy_moods_triggered(trigger_type: Mood.TriggerType, enemy: Enemy) -> void:
	match trigger_type:
		Mood.TriggerType.START_OF_TURN:
			enemy.take_turn()
		Mood.TriggerType.END_OF_TURN:
			acting_enemies.erase(enemy)
			_start_next_enemy_turn()

func _on_enemy_died(enemy: Enemy) -> void:
	var is_enemy_turn := acting_enemies.size() > 0
	acting_enemies.erase(enemy)
	if is_enemy_turn:
		_start_next_enemy_turn()
	# This function stops funny business from happening if an enemy dies on their turn.

func _on_enemy_action_completed(enemy: Enemy) -> void:
	enemy.mood_handler.trigger_moods_by_type(Mood.TriggerType.END_OF_TURN)
